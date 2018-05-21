class ProjectsController < ApplicationController

  def show

    @albums = Album.all()

  end

  def images

    @album = Album.find_by_name params[:name]

    if (!@album)
      redirect_to "/projects"
    end

  end
end
