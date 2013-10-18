module LoyaltyConnect
  class Connection
    DEFAULT_JSON_RESULT = "{}"

    def initialize url_helper, api_client
      @url_helper = url_helper
      @api_client = api_client
    end

    attr_reader :url_helper, :api_client

    def exist?
      found = true
      get(url_helper.show) do |error|
        found = false
      end
      found
    end

    def rewards
      get url_helper.rewards
    end

    def transactions
      get url_helper.transactions
    end

    def cards
      get url_helper.cards
    end

    def activity
      get url_helper.activity
    end

    def reward_detail id_param
      get url_helper.reward(id_param)
    end

    def transaction_detail id_param
      get url_helper.transaction(id_param)
    end

    def card_detail id_param
      get url_helper.card(id_param)
    end

    def register_user params
      post url_helper.create_user, params
    end

    def delete_user
      delete url_helper.delete_user, {}
    end

    def new_credit_card
      get url_helper.new_credit_card
    end

    def create_credit_card params
      post url_helper.create_credit_card, params
    end

    def delete_credit_card credit_card_id
      delete url_helper.delete_credit_card(credit_card_id), {}
    end

    private

    def get(url)
      api_client.get(url) do |error|
        yield error if block_given?
        raise unless error.message.include?('404')
        DEFAULT_JSON_RESULT
      end
    end

    def post(url, params)
      api_client.post(url, params) do |error|
        yield error if block_given?
        raise unless error.message.include?('404')
        DEFAULT_JSON_RESULT
      end
    end

    def delete(url, params)
      api_client.delete(url, params) do |error|
        yield error if block_given?
        raise unless error.message.include?('404')
        DEFAULT_JSON_RESULT
      end
    end

  end
end
