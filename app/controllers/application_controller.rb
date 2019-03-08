class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  #def after_sign_in_path_for
  #end
end
