class Admin::ProjectsController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index

  end

end
