module LoyaltyConnect
  class UrlHelper

    def initialize consumer_id, should_translate=true
      @consumer_id = consumer_id
      @should_translate = should_translate
    end

    attr_reader :should_translate

    def rewards
      path 'rewards'
    end

    def transactions
      path 'transactions'
    end

    def cards
      path 'credit_cards'
    end

    def activity
      path 'activity'
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
      @cached_consumer_id ||= if @consumer_id.respond_to? :call
        @consumer_id.call
      else
        @consumer_id
      end
    end

    private

    def path *segments
      path = ['', 'api', 'consumers', consumer_id, *segments].join('/')
      path.concat('?translate=1') if should_translate
    end

  end
end
