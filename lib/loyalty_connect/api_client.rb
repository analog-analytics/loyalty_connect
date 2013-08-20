require 'oauth2'

module LoyaltyConnect
  class ApiClient
    def initialize oauth_wrapper
      @oauth_wrapper = oauth_wrapper
    end

    attr_reader :oauth_wrapper

    def get url, &error_handler
      call_api :get, url, {}, &error_handler
    end

    def post url, params, &error_handler
      call_api :post, url, params, &error_handler
    end

    def delete url, params, &error_handler
      call_api :delete, url, params, &error_handler
    end

    private

    RaisingErrorHandler = lambda { |e| raise e }

    def call_api method, url, params, &error_handler
      handle_with_care(error_handler) do
        oauth_wrapper.oauth_token.send method, url, params, headers
      end
    end

    def handle_with_care error_handler, &block
      error_handler ||= RaisingErrorHandler
      result = block.call
      String(result).strip
    rescue OAuth2::HTTPError => e
      error_handler.call(e)
    end

    def headers
      { 'X-API-Version' => version }
    end

    def version
      '1.0.0'
    end

  end
end
