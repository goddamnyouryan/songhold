class ApplicationController < ActionController::Base
  before_action :redirect_if_signed_in, only: :home

  def home
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to root_path unless current_user
  end

  private

  def redirect_if_signed_in
    redirect_to playlists_path if current_user
  end
end
