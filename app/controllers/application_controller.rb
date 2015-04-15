class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # For log-in, log-out functionality, SessionHelper is created and included
  include SessionsHelper
end
