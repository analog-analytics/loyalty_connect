require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe "ParsedApiClient" do

    it "should use the JSON class for default parser" do
      client = ParsedApiClient.new(Object.new)
      assert_equal JSON, client.result_parser
    end

  end
end
