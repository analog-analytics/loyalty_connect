require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe PagedItems do
      describe "parsing from json" do
        before do
          json = JSON.parse(%q({
            "previous_uri": "/previous",
            "current_uri": "/current",
            "next_uri": "/next",
            "something": [
              { "id": "10" }, { "id": "11" }
            ]
          }))
          @converted_called = 0
          @paged_items = PagedItems.from_json_hash(json, "something") { |i| @converted_called += 1 }
        end

        specify { @paged_items.previous_url.must_equal "/previous" }
        specify { @paged_items.current_url.must_equal "/current" }
        specify { @paged_items.next_url.must_equal "/next" }
        specify { @paged_items.items.length.must_equal 2 }
        specify { @converted_called.must_equal 2 }
      end
    end
  end
end
