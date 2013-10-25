module LoyaltyConnect
  module Model
    class Activity < Struct.new(:cards, :transactions, :rewards)
      class << self
        def from_json_hash(json_hash)
          data = json_hash || {}
          Activity.new(
            Card.from_paged_json(data["credit_cards"]),
            Transaction.from_paged_json(data["transactions"]),
            Reward.from_paged_json(data["rewards"])
          )
        end
      end
    end
  end
end
