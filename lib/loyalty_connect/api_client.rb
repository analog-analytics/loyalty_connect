require 'oauth2'

module LoyaltyConnect
  class ApiClient
    def initialize oauth_wrapper
      @oauth_wrapper = oauth_wrapper
    end

    attr_reader :oauth_wrapper

    def get url
      oauth_wrapper.oauth_token.get url, {}, headers
    rescue OAuth2::HTTPError => e
      return nil if e.message[/404/]
      #TODO: Need to add logging here. Assuming that these other errors are needed
      nil
    end

    private

    def headers
      { 'X-API-Version' => version }
    end

    def version
      '1.0.0'
    end

  end
end
