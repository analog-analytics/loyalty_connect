require "loyalty_connect/version"
require "loyalty_connect/url_helper"
require "loyalty_connect/api_client"
require "loyalty_connect/parsed_api_client"
require "loyalty_connect/connection"
require "loyalty_connect/oauth_wrapper"

module LoyaltyConnect
  class << self
    def create consumer_id, options={}
      url_helper = UrlHelper.new(consumer_id, options['translate'])
      oauth_wrapper = OauthWrapper.new(options)
      api_client = ParsedApiClient.new(oauth_wrapper)
      Connection.new url_helper, api_client
    end
  end
end
