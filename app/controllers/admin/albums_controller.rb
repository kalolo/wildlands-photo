class Admin::AlbumsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    @albums = Album.all
  end
end
