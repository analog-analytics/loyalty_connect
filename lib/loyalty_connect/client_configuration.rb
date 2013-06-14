require 'yaml'

module LoyaltyConnect
  class ClientConfiguration
    def initialize yaml_path="#{Rails.root}/config/loyalty_connect.yml", environment=Rails.env
      config = YAML.load(File.open(yaml_path))[environment]
      @server = config['server']
      @client_id = config['client_id']
      @client_secret = config['client_secret']
      @username = config['username']
      @password = config['password']
    end

    attr_reader :server, :client_id, :client_secret, :username, :password

    def connection_for consumer_model
      url_helper = UrlHelper.new(consumer_model)
      api_client = ApiClient.new(oauth_token)
      Connection.new url_helper, api_client
    end

    private

    def oauth_token
      @oauth_token ||= OauthWrapper.new(self)
    end
  end
end
