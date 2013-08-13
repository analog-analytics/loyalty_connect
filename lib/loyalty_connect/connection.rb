module LoyaltyConnect
  class Connection

    DEFAULT_ARRAY_RESULT = "[]"
    DEFAULT_HASH_RESULT = "{}"

    def initialize url_helper, api_client
      @url_helper = url_helper
      @api_client = api_client
    end

    attr_reader :url_helper, :api_client

    def exist?
      found = true
      get(url_helper.show, DEFAULT_HASH_RESULT) do |error|
        found = false
      end
      found
    end

    def rewards
      get url_helper.rewards, DEFAULT_ARRAY_RESULT
    end

    def transactions
      get url_helper.transactions, DEFAULT_ARRAY_RESULT
    end

    def cards
      get url_helper.cards, DEFAULT_ARRAY_RESULT
    end

    def activity
      get url_helper.activity, DEFAULT_HASH_RESULT
    end

    def reward_detail id_param
      get url_helper.reward(id_param), DEFAULT_HASH_RESULT
    end

    def transaction_detail id_param
      get url_helper.transaction(id_param), DEFAULT_HASH_RESULT
    end

    def card_detail id_param
      get url_helper.card(id_param), DEFAULT_HASH_RESULT
    end

    def register_user
      post url_helper.create_user, {}, DEFAULT_HASH_RESULT
    end

    def new_credit_card
      get url_helper.new_credit_card, DEFAULT_HASH_RESULT
    end

    private

    def get(url, not_found_value)
      api_client.get(url) do |error|
        yield error if block_given?
        raise unless error.message.include?('404')
        not_found_value
      end
    end

    def post(url, params, not_found_value)
      api_client.post(url, params) do |error|
        yield error if block_given?
        raise unless error.message.include?('404')
        not_found_value
      end
    end

  end
end
