require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe Reward do
      describe "parsing from json" do
        before do
          json = JSON.parse(%q({
            "id": "4",
            "url": "/someplace",
            "rewarded_at": "some time",
            "rewarded_amount": "1234"
          }))
          @reward = Reward.from_json_hash(json)
        end

        specify { @reward.id.must_equal "4" }
        specify { @reward.url.must_equal "/someplace" }
        specify { @reward.rewarded_at.must_equal "some time" }
        specify { @reward.rewarded_amount.must_equal 12.34 }
      end

      describe "parsing paged items" do
        before do
          json = JSON.parse(%q({
            "previous_uri": "/previous",
            "current_uri": "/current",
            "next_uri": "/next",
            "rewards": [
              { "id": "10" }, { "id": "11" }
            ]
          }))
          @paged_rewards = Reward.from_paged_json(json)
        end

        specify { @paged_rewards.previous_url.must_equal "/previous" }
        specify { @paged_rewards.current_url.must_equal "/current" }
        specify { @paged_rewards.next_url.must_equal "/next" }
        specify { @paged_rewards.items.length.must_equal 2 }
      end
    end
  end
end
