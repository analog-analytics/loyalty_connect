require 'yaml'

module LoyaltyConnect
  class ClientConfiguration

    def initialize params={}
      options = params || Hash.new
      defaults.merge(options).each do |k,v|
        self.send("#{k}=", v.to_s)
      end
    end

    attr_accessor :server, :client_id, :client_secret, :username, :password

    def connection_for consumer_model
      url_helper = UrlHelper.new(consumer_model)
      api_client = ApiClient.new(oauth_token)
      Connection.new url_helper, api_client
    end

    private

    def oauth_token
      @oauth_token ||= OauthWrapper.new(self).oauth_token
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
