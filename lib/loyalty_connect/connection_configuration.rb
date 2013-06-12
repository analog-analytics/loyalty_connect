require 'yaml'

module LoyaltyConnect
  class ConnectionConfiguration
    def initialize yaml_path="#{Rails.root}/config/loyalty_connect.yml", environment=Rails.env
      config = YAML.load(File.open(yaml_path))[environment]
      @server = config['server']
      @client_id = config['client_id']
      @client_secret = config['client_secret']
      @username = config['username']
      @password = config['password']
    end

    attr_reader :server, :client_id, :client_secret, :username, :password
  end
end
