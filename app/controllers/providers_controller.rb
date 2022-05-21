class ProvidersController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    @provider = Provider.from_omniauth provider_params
    redirect_to root_path, notice: 'Ringcentral connected.'
  end

  private

  def provider_params
    {
      user_id: current_user.id,
      uid: auth.uid,
      name: 'Ringcentral',
      identifier: auth.extra.raw_info.mainNumber,
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
