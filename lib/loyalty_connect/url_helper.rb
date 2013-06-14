module LoyaltyConnect
  class UrlHelper

    def initialize consumer_id
      @consumer_id = consumer_id
    end

    def rewards
      path 'rewards'
    end

    def transactions
      path 'transactions'
    end

    def cards
      path 'credit_cards'
    end

    def reward id_param
      path 'rewards', id_param
    end

    def transaction id_param
      path 'transactions', id_param
    end

    def card id_param
      path 'credit_cards', id_param
    end

    def consumer_id
      if @consumer_id.respond_to? :call
        @consumer_id.call
      else
        @consumer_id
      end
    end

    private

    def path *segments
      ['', 'api', version, 'consumers', consumer_id, *segments].join('/')
    end

    def version
      "1.0.0"
    end

  end
end
