require 'oauth2'

module LoyaltyConnect
  class ApiClient
    def initialize oauth_wrapper
      @oauth_wrapper = oauth_wrapper
    end

    attr_reader :oauth_wrapper

    def get url, default=nil
      default ||= Default_value
      result = oauth_wrapper.oauth_token.get(url, {}, headers)
      handle_result(result, default)
    rescue OAuth2::HTTPError => e
      return default.call if e.message[/404/]
      raise
    end

    def post url, options, default=nil
      default ||= Default_value
      result = oauth_wrapper.oauth_token.post(url, options, headers)
      handle_result(result, default)
    rescue OAuth2::HTTPError => e
      return default.call if e.message[/404/]
      raise
    end

    private

    Default_value = lambda { nil }

    def headers
      { 'X-API-Version' => version }
    end

    def version
      '1.0.0'
    end

    def handle_result(raw_result, default)
      result = String(raw_result).strip
      if result.empty?
        default.call
      else
        result
      end
    end

  end
end
