module LoyaltyConnect
  class UrlHelper

    def initialize consumer_id, should_translate
      @consumer_id = consumer_id
      @should_translate = !! should_translate
    end

    attr_reader :should_translate

    def consumer_id
      @cached_consumer_id ||= get_consumer_id
    end

    def transactions
      path consumer_id, 'transactions'
    end

    def transaction id_param
      path consumer_id, 'transactions', id_param
    end

    def rewards
      path consumer_id, 'rewards'
    end

    def reward id_param
      path consumer_id, 'rewards', id_param
    end

    def activity
      path consumer_id, 'activity'
    end

    def show
      path consumer_id
    end

    alias_method :delete_user, :show

    def create_user
      create_path = url_path
      create_path.concat("?translate=#{consumer_id}") if should_translate
      create_path
    end

    def cards
      path consumer_id, 'credit_cards'
    end

    alias_method :create_credit_card, :cards

    def card credit_card_id
      path consumer_id, 'credit_cards', credit_card_id
    end

    alias_method :delete_credit_card, :card

    def new_credit_card
      path consumer_id, 'credit_cards', 'new'
    end

    private

    def path *segments
      path = url_path(segments)
      path.concat('?translate=1') if should_translate
      path
    end

    def url_path *segments
      ['', 'api', 'consumers', *segments].join('/')
    end

    def get_consumer_id
      consumer_id = if @consumer_id.respond_to? :call
        @consumer_id.call
      else
        @consumer_id
      end
      consumer_id.to_s
    end
  end
end
