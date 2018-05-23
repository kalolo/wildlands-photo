namespace :photo do
  desc "Upload photos from path"
  task :path_reader, [:path] => :environment do |t, args|

    root_path = args.path

    puts "  [+] #{Time.now} Reading photos #{args.path}"

    imgur_config = Rails.configuration.imgur

    imgur_session = Imgurapi::Session.instance(
        client_id: imgur_config['client_id'],
        client_secret: imgur_config['client_secret'],
        refresh_token: imgur_config['refresh_token'],
        access_token: imgur_config['access_token']
    )

    uploaded_count = 0

    Dir.entries(root_path).select {
        |entry| File.directory? File.join(root_path, entry) and !(entry =='.' || entry == '..')
    }.each do |album_name|

      album = Album.find_by_name(album_name)

      if (!album)
        album = Album.create({name: album_name})
      end

      Dir.entries("#{root_path}/#{album_name}").select {
          |f| File.file? File.join("#{root_path}/#{album_name}/#{f}")
      }.each do |image_file|

        image = Image.where(album_id: album.id, name: image_file)

        if (!image.exists?)
          puts "      > Uploading #{root_path}/#{album_name}/#{image_file} [#{uploaded_count}]"
          begin

            uploaded_count += 1

            uploaded_image = imgur_session.image.image_upload("#{root_path}/#{album_name}/#{image_file}")
            image = Image.new
            image.external_id = uploaded_image.id
            image.album_id = album.id
            image.name = image_file
            image.image_type = uploaded_image.type
            image.width = uploaded_image.width
            image.height = uploaded_image.height
            image.size = uploaded_image.size
            image.link = uploaded_image.link
            image.deletehash = uploaded_image.deletehash
            image.save

            if (uploaded_count == 50)
              uploaded_count = 0
              puts "      { sleeping for 1 hour} #{Time.now} see you at: " + (Time.now + 1.hours).to_s
              sleep 1.hours
            end

          rescue => ex
            puts 'Exception: Unable to upload photo!! ' + ex.message
            exit
          end
        end
      end
    end
  end

  desc "Upload photos from path to cloudinary"
  task :cloudinary_uploader, [:path] => :environment do |t, args|
    root_path = args.path

    puts "  [+] #{Time.now} Reading photos #{args.path}"

    Dir.entries(root_path).select {
        |entry| File.directory? File.join(root_path, entry) and !(entry =='.' || entry == '..')
    }.each do |album_name|

      album = Album.find_or_create_by(name: album_name)

      Dir.entries("#{root_path}/#{album_name}").select {
          |f| File.file? File.join("#{root_path}/#{album_name}/#{f}")
      }.each do |image_file|

        next unless !Image.exists?(name: image_file, album_id: album.id)

        puts "      > Uploading #{root_path}/#{album_name}/#{image_file}"

        uploaded_image = OpenStruct.new(Cloudinary::Uploader.upload("#{root_path}/#{album_name}/#{image_file}",
          :folder => '/images/wildlands/photos',
           :resource_type => 'image'
        ))

        image = Image.new
        image.external_id = uploaded_image.public_id
        image.album_id = album.id
        image.name = image_file
        image.image_type = uploaded_image.format
        image.width = uploaded_image.width
        image.height = uploaded_image.height
        image.size = uploaded_image.bytes
        image.link = uploaded_image.url
        image.container = 'cloudinary'
        image.save

      end
    end
  end
end
