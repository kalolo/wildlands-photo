json.extract! image, :id, :id, :external_id, :name, :description, :album_id, :link, :width, :height, :size, :type, :created_at, :updated_at
json.url image_url(image, format: :json)
