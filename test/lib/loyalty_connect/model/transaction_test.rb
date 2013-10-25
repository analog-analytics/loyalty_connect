require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe Transaction do
      describe "parsing from json" do
        before do
          json = JSON.parse(%q({
            "id": "4",
            "url": "/someplace",
            "merchant": { "name": "blah" },
            "purchaseDate": "when",
            "creditCard": { "brand": "my card", "last_4": "2345" },
            "status": "something",
            "amount": "2345",
            "currency": "usd",
            "rewardAmount": "3942"
          }))
          @transaction = Transaction.from_json_hash(json)
        end

        specify { @transaction.id.must_equal "4" }
        specify { @transaction.url.must_equal "/someplace" }
        specify { @transaction.brand.must_equal "my card" }
        specify { @transaction.last_4.must_equal "2345" }
        specify { @transaction.status.must_equal "something" }
        specify { @transaction.amount.must_equal 23.45 }
        specify { @transaction.currency.must_equal "usd" }
        specify { @transaction.reward_amount.must_equal 39.42 }
      end

      describe "parsing paged items" do
        before do
          json = JSON.parse(%q({
            "previous_uri": "/previous",
            "current_uri": "/current",
            "next_uri": "/next",
            "transactions": [
              { "id": "10" }, { "id": "11" }
            ]
          }))
          @paged_transactions = Transaction.from_paged_json(json)
        end

        specify { @paged_transactions.previous_url.must_equal "/previous" }
        specify { @paged_transactions.current_url.must_equal "/current" }
        specify { @paged_transactions.next_url.must_equal "/next" }
        specify { @paged_transactions.items.length.must_equal 2 }
      end
    end
  end
end
