require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Homework < OmniAuth::Strategies::OAuth2
      option :name, :homework

      option :client_options, {
        site: ENV['PROVIDER_URL'],
        authorize_path: "/oauth/authorize"
      }

      uid do
        raw_info["id"]
      end

      info do
        {name: raw_info["name"]}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/me.json').parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end