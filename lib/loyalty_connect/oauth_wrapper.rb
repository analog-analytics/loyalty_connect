require 'oauth2'

module LoyaltyConnect
  class OauthWrapper

    def initialize client_configuration, client_class = OAuth2::Client
      @client_class = client_class
      options = client_configuration || Hash.new
      @server = options['server']
      @client_id = options['client_id']
      @client_secret = options['client_secret']
      @username = options['username']
      @password = options['password']
    end

    attr_accessor :server, :client_id, :client_secret, :username, :password, :client_class

    def oauth_token
      @oauth_token ||= create_oauth_token
    end

    private

    def oauth_client
      @oauth_client ||= create_oauth_client
    end

    def create_oauth_client
      client_class.new(
        client_id,
        client_secret,
        :site => server
      )
    end

    def password_workflow
      oauth_client.password
    end

    def create_oauth_token
      password_workflow.get_token(username, password)
    end

  end
end
