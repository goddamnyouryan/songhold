class RingCentral
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def upload_custom_greeting(type, track)
    headers = {
      'content-type': 'multipart/mixed'
    }

    params = {
      type: type,
      binary: track
    }

    debugger

    post 'greeting', headers, params
  end

  def post(uri, headers, params)
    merged_headers = default_headers.merge(headers)
    HTTParty.post "#{ENV['RINGCENTRAL_SERVER_URL']}/restapi/v1.0/account/~/extension/~/#{uri}", headers: merged_headers, body: params
  end

  def default_headers
    {
      accept: 'application/json',
      authorization: "Bearer #{token}"
    }
  end
end
