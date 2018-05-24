class ProjectsController < ApplicationController

  layout "gallery", :only => [:images, :image]

  def show

    @albums = Album.all()

  end

  def images

    @album = Album.includes(:images).find_by_name params[:name]

    if (!@album)
      redirect_to "/projects"
    end
  end

  def image
    @image = Image.find(params[:imageid])
    @album = @image.album

  end

end
