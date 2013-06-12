require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe UrlHelper do

      before do
        consumer = Class.new do
          def self.loyalty_id
            18
          end
        end
        @url_helper = UrlHelper.new consumer
      end

      it "creates rewards URLs" do
        assert_equal "/api/1.0.0/consumer/18/rewards", @url_helper.rewards
      end

      it "creates transactions URLs" do
        assert_equal "/api/1.0.0/consumer/18/transactions", @url_helper.transactions
      end

      it "creates credit cards URLs" do
        assert_equal "/api/1.0.0/consumer/18/credit_cards", @url_helper.cards
      end

      it "creates reward detail URLs" do
        assert_equal "/api/1.0.0/consumer/18/rewards/15", @url_helper.reward(15)
      end

      it "creates transaction  detail URLs" do
        assert_equal "/api/1.0.0/consumer/18/transactions/16", @url_helper.transaction(16)
      end

      it "creates credit card detail URLs" do
        assert_equal "/api/1.0.0/consumer/18/credit_cards/17", @url_helper.card(17)
      end

    end
  end
