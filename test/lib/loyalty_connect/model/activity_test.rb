require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe Activity do
      it "parsing from json" do
          json = {
            "credit_cards" => :cards,
            "transactions" => :transactions,
            "rewards" => :rewards
          }
          Model::Card.expects(:from_paged_json).with(:cards).returns(:card_return)
          Model::Transaction.expects(:from_paged_json).with(:transactions).returns(:transaction_return)
          Model::Reward.expects(:from_paged_json).with(:rewards).returns(:reward_return)

          activity = Activity.from_json_hash(json)

          activity.cards.must_equal :card_return
          activity.transactions.must_equal :transaction_return
          activity.rewards.must_equal :reward_return
      end
    end
  end
end
