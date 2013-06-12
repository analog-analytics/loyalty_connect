require 'oauth2'

module LoyaltyConnect
  class ApiClient
    def initialize configuration
      @configuration = configuration
    end

    def get url
      oauth_token.get url
    end

    private

    attr_reader :configuration

    def oauth_client
      @oauth_client ||= create_oauth_client
    end

    def oauth_token
      @oauth_token ||= create_oauth_token
    end

    def create_oauth_client
      OAuth2::Client.new(
        configuration.client_id,
        configuration.client_secret,
        :site => configuration.server,
        :access_token_path => "/oauth/token")
    end

    def create_oauth_token
      token = oauth_client.password.get_access_token(configuration.username, configuration.password)
      token.token_param = 'access_token'
      token
    end

  end
end
