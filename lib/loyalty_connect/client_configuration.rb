require 'yaml'

module LoyaltyConnect
  class ClientConfiguration

    def initialize params={}
      options = params || Hash.new
      @server = options.fetch('server') { '' }
      @client_id = options.fetch('client_id') { '' }
      @client_secret = options.fetch('client_secret') { '' }
      @username = options.fetch('username') { '' }
      @password = options.fetch('password') { '' }
    end

    attr_accessor :server, :client_id, :client_secret, :username, :password

    def connection_for consumer_model
      url_helper = UrlHelper.new(consumer_model)
      api_client = ApiClient.new(oauth_wrapper)
      Connection.new url_helper, api_client
    end

    private

    def oauth_wrapper
      @oauth_wrapper ||= OauthWrapper.new(self)
    end

    def defaults
      {
        'server' => '',
        'client_id' => '',
        'client_secret' => '',
        'username' => '',
        'password' => ''
      }
    end
  end
end
