require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Ringcentral < OmniAuth::Strategies::OAuth2
      option :name, 'ringcentral'

      option :client_options, {
        site: ENV['RINGCENTRAL_SERVER_URL'],
        authorize_url: '/restapi/oauth/authorize',
        token_url: '/restapi/oauth/token',
      }

      # dont know how to run this? a proc maybe?
      # would make things cleaner than overwriting the token generation methods
      # option :auth_token_params, auth_header

      def build_access_token
        # overwrote from here: https://rdoc.info/github/intridea/oauth2/OAuth2/Strategy/AuthCode#get_token-instance_method
        # and here: https://www.rubydoc.info/github/intridea/oauth2/OAuth2/Client#get_token-instance_method
        client.auth_code.get_token(request.params['code'], { redirect_uri: ENV['RINGCENTRAL_REDIRECT_URI'], headers: auth_header })
      end

      def auth_header
        header = Base64.encode64("#{client.id}:#{client.secret}").gsub(/\s/, '')
        { 'Authorization' => "Basic #{header}" }
      end

      uid do
        raw_info['id']
      end

      info do
        { }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/restapi/v1.0/account/~').parsed
      end
    end
  end
end
