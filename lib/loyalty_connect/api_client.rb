require 'oauth2'

module LoyaltyConnect
  class ApiClient
    def initialize oauth_token
      @oauth_token = oauth_token
    end

    def get url
      oauth_token.get url
    rescue OAuth2::HTTPError => e
      return nil if e.message[/404/]
      #TODO: Need to add logging here. Assuming that these other errors are needed
      nil
    end

    private

    attr_reader :oauth_token
  end
end
