module LoyaltyConnect
  class Connection


    def initialize url_helper, api_client
      @url_helper = url_helper
      @api_client = api_client
    end

    attr_reader :url_helper, :api_client

    def rewards
      api_client.get(url_helper.rewards, Default_array_result)
    end

    def transactions
      api_client.get(url_helper.transactions, Default_array_result)
    end

    def cards
      api_client.get(url_helper.cards, Default_array_result)
    end

    def activity
      api_client.get(url_helper.activity, Default_hash_result)
    end

    def reward_detail id_param
      api_client.get(url_helper.reward(id_param), Default_hash_result)
    end

    def transaction_detail id_param
      api_client.get(url_helper.transaction(id_param), Default_hash_result)
    end

    def card_detail id_param
      api_client.get(url_helper.card(id_param), Default_hash_result)
    end

    def register_user
      api_client.post(url_helper.create_user, {}, Default_hash_result)
    end

    private

    Default_array_result = lambda { '[]' }
    Default_hash_result = lambda { '{}' }

  end
end
