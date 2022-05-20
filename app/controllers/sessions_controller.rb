class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth user_params
    session[:user_id] = @user.id
    redirect_to root_path, notice: 'Signed in.'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

  private

  def user_params
    {
      uid: auth.uid,
      email: auth.info.email,
      token: credentials.token,
      refresh: credentials.refresh_token,
      expires_at: Time.at(credentials.expires_at),
    }
  end

  def auth
    request.env['omniauth.auth']
  end

  def credentials
    auth.credentials
  end
end
