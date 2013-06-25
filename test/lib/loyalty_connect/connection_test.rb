require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe Connection do
    before do
      @mock_api_client = MiniTest::Mock.new
      @mock_url_helper = MiniTest::Mock.new
      @connection = Connection.new @mock_url_helper, @mock_api_client
    end

    after do
      @mock_api_client.verify
      @mock_url_helper.verify
    end

    describe "default returns" do
      before do
        def @mock_api_client.get url
          nil
        end
      end

      it "returns an empty array if nil from api for rewards" do
        def @mock_url_helper.rewards
          nil
        end
        rewards = @connection.rewards
        assert_equal [], rewards
      end

      it "returns an empty array if nil from api for transactions" do
        def @mock_url_helper.transactions
          nil
        end
        transactions = @connection.transactions
        assert_equal [], transactions
      end

      it "returns an empty array if nil from api for cards" do
        def @mock_url_helper.cards
          nil
        end
        cards = @connection.cards
        assert_equal [], cards
      end

      it "returns an empty array if nil from api for activity" do
        def @mock_url_helper.activity
          nil
        end
        activity = @connection.activity
        assert_equal [], activity
      end

      it "returns an empty hash if nil from api for reward details" do
        def @mock_url_helper.reward id_param
          nil
        end
        reward = @connection.reward_detail 12
        assert_kind_of Hash, reward
      end

      it "returns an empty hash if nil from api for transaction details" do
        def @mock_url_helper.transaction id_param
          nil
        end
        transaction = @connection.transaction_detail 12
        assert_kind_of Hash, transaction
      end

      it "returns an empty hash if nil from api for card details" do
        def @mock_url_helper.card id_param
          nil
        end
        card = @connection.card_detail 12
        assert_kind_of Hash, card
      end

    end

    describe "API return" do
      before do
        @expected = Object.new
      end

      it "return an array of rewards" do
        @mock_api_client.expect :get, [@expected], ["blah2"]
        @mock_url_helper.expect :rewards, "blah2"
        rewards = @connection.rewards
        assert_equal [@expected], rewards
      end

      it "return an array of transactions" do
        @mock_api_client.expect :get, [@expected], ["blah3"]
        @mock_url_helper.expect :transactions, "blah3"
        transactions = @connection.transactions
        assert_equal [@expected], transactions
      end

      it "return an array of cards" do
        @mock_api_client.expect :get, [@expected], ["blah1"]
        @mock_url_helper.expect :cards, "blah1"
        cards = @connection.cards
        assert_equal [@expected], cards
      end

      it "returns what reward details api reward detail" do
        @mock_api_client.expect :get, @expected, ["blah6"]
        @mock_url_helper.expect :reward, "blah6", [12]
        reward = @connection.reward_detail 12
        assert_equal @expected, reward
      end

      it "returns what transaction details api transaction detail" do
        @mock_api_client.expect :get, @expected, ["blah4"]
        @mock_url_helper.expect :transaction, "blah4", [12]
        transaction = @connection.transaction_detail 12
        assert_equal @expected, transaction
      end

      it "returns what card details api card detail" do
        @mock_api_client.expect :get, @expected, ["blah5"]
        @mock_url_helper.expect :card, "blah5", [12]
        card = @connection.card_detail 12
        assert_equal @expected, card
      end

    end

  end
end
