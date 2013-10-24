require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe Card do
      describe "parsing from json" do
        before do
          json = JSON.parse(%q({
            "id": "4",
            "url": "/someplace",
            "last_4": "2345",
            "brand": "my card",
            "bank": "the bank",
            "brand_string": "MC",
            "country": "this one"
          }))
          @card = Card.from_json_hash(json)
        end

        specify { @card.id.must_equal "4" }
        specify { @card.url.must_equal "/someplace" }
        specify { @card.last_4.must_equal "2345" }
        specify { @card.brand.must_equal "my card" }
        specify { @card.bank.must_equal "the bank" }
        specify { @card.brand_string.must_equal "MC" }
        specify { @card.country.must_equal "this one" }
      end

      describe "parsing paged items" do
        before do
          json = JSON.parse(%q({
            "previous_uri": "/previous",
            "current_uri": "/current",
            "next_uri": "/next",
            "credit_cards": [
              { "id": "10" }, { "id": "11" }
            ]
          }))
          @paged_cards = Card.from_paged_json(json)
        end

        specify { @paged_cards.previous_url.must_equal "/previous" }
        specify { @paged_cards.current_url.must_equal "/current" }
        specify { @paged_cards.next_url.must_equal "/next" }
        specify { @paged_cards.items.length.must_equal 2 }
      end
    end
  end
end
