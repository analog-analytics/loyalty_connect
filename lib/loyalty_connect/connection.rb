require 'json'

module LoyaltyConnect
  class Connection

    def initialize url_helper, api_client, result_parser = JSON
      @url_helper = url_helper
      @api_client = api_client
      @result_parser = result_parser
    end

    attr_reader :url_helper, :api_client, :result_parser

    def rewards
      api_fetch(url_helper.rewards) { [] }
    end

    def transactions
      api_fetch(url_helper.transactions) { [] }
    end

    def cards
      api_fetch(url_helper.cards) { [] }
    end

    def activity
      api_fetch(url_helper.activity) { Hash.new }
    end

    def reward_detail id_param
      api_fetch(url_helper.reward(id_param)) { Hash.new }
    end

    def transaction_detail id_param
      api_fetch(url_helper.transaction(id_param)) { Hash.new }
    end

    def card_detail id_param
      api_fetch(url_helper.card(id_param)) { Hash.new }
    end

    private

    def api_fetch(path, &default)
      result = api_client.get(path).to_s.strip
      if result.empty?
        default.call
      else
        result_parser.parse(result)
      end
    end

  end
end
