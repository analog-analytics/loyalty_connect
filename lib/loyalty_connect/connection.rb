module LoyaltyConnect
  class Connection

    def initialize url_helper, api_client
      @url_helper = url_helper
      @api_client = api_client
    end

    def rewards
      @api_client.get(@url_helper.rewards) || []
    end

    def transactions
      @api_client.get(@url_helper.transactions) || []
    end

    def cards
      @api_client.get(@url_helper.cards) || []
    end

    def reward_detail id_param
      @api_client.get(@url_helper.reward(id_param)) || Hash.new
    end

    def transaction_detail id_param
      @api_client.get(@url_helper.transaction(id_param)) || Hash.new
    end

    def card_detail id_param
      @api_client.get(@url_helper.card(id_param)) || Hash.new
    end

  end
end