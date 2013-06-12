module LoyaltyConnect
  class UrlHelper

    def initialize consumer_model
      @consumer_id = consumer_model.loyalty_id
    end

    def rewards
      "/api/1.0.0/consumer/#{@consumer_id}/rewards"
    end

    def transactions
      "/api/1.0.0/consumer/#{@consumer_id}/transactions"
    end

    def cards
      "/api/1.0.0/consumer/#{@consumer_id}/credit_cards"
    end

    def reward id_param
      "/api/1.0.0/consumer/#{@consumer_id}/rewards/#{id_param}"
    end

    def transaction id_param
      "/api/1.0.0/consumer/#{@consumer_id}/transactions/#{id_param}"
    end

    def card id_param
      "/api/1.0.0/consumer/#{@consumer_id}/credit_cards/#{id_param}"
    end

  end
end
