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
      Model::Reward.from_paged_json(get(url_helper.rewards))
    end

    def transactions
      Model::Transaction.from_paged_json(get(url_helper.transactions))
    end

    def cards
      Model::Card.from_paged_json(get(url_helper.cards))
    end

    def activity
      Model::Activity.from_json_hash(get(url_helper.activity))
    end

    def register_user params
      Model::CreateUserResult.from_json_hash(post(url_helper.create_user, params))
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
