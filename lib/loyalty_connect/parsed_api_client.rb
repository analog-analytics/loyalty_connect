require 'json'

module LoyaltyConnect
  class ParsedApiClient < ApiClient
    def initialize oauth_wrapper, result_parser = JSON
      @result_parser = result_parser
      super(oauth_wrapper)
    end

    attr_reader :result_parser

    def get(*args)
      result_parser.parse(super)
    end

    def post(*args)
      result_parser.parse(super)
    end
  end
end
