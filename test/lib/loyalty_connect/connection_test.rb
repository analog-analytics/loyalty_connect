require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe "default returns" do
    before do
      api_client = Object.new
      def api_client.get(url); nil ; end
      @url_helper = Object.new
      @connection = Connection.new @url_helper, api_client
    end

    it "returns an empty array if nil from api for rewards" do
      def @url_helper.rewards; nil; end
      rewards = @connection.rewards
      assert_equal [], rewards
    end

    it "returns an empty array if nil from api for transactions" do
      def @url_helper.transactions; nil; end
      transactions = @connection.transactions
      assert_equal [], transactions
    end

    it "returns an empty array if nil from api for cards" do
      def @url_helper.cards; nil; end
      cards = @connection.cards
      assert_equal [], cards
    end

    it "returns an empty hash if nil from api for activity" do
      def @url_helper.activity; nil; end
      activity = @connection.activity
      assert_kind_of Hash, activity
    end

    it "returns an empty hash if nil from api for reward details" do
      def @url_helper.reward(id_param); nil; end
      reward = @connection.reward_detail 12
      assert_kind_of Hash, reward
    end

    it "returns an empty hash if nil from api for transaction details" do
      def @url_helper.transaction(id_param); nil; end
      transaction = @connection.transaction_detail 12
      assert_kind_of Hash, transaction
    end

    it "returns an empty hash if nil from api for card details" do
      def @url_helper.card(id_param); nil; end
      card = @connection.card_detail 12
      assert_kind_of Hash, card
    end

  end

  describe "API operation" do
    before do
      @mock_api_client = MiniTest::Mock.new
      @mock_url_helper = MiniTest::Mock.new
      @mock_result_parser = MiniTest::Mock.new
      @connection = Connection.new @mock_url_helper, @mock_api_client, @mock_result_parser
      @expected = Object.new
    end

    after do
      @mock_api_client.verify
      @mock_url_helper.verify
      @mock_result_parser.verify
    end

    it "return an array of rewards" do
      @mock_url_helper.expect :rewards, "rewards1"
      @mock_api_client.expect :get, "rewards2", ["rewards1"]
      @mock_result_parser.expect :parse, [@expected], ["rewards2"]
      rewards = @connection.rewards
      assert_equal [@expected], rewards
    end

    it "return an array of transactions" do
      @mock_url_helper.expect :transactions, "transactions1"
      @mock_api_client.expect :get, "transactions2", ["transactions1"]
      @mock_result_parser.expect :parse, [@expected], ["transactions2"]
      transactions = @connection.transactions
      assert_equal [@expected], transactions
    end

    it "return an array of cards" do
      @mock_url_helper.expect :cards, "cards1"
      @mock_api_client.expect :get, "cards2", ["cards1"]
      @mock_result_parser.expect :parse, [@expected], ["cards2"]
      cards = @connection.cards
      assert_equal [@expected], cards
    end

    it "return a hash of activity" do
      @mock_url_helper.expect :activity, "activity1"
      @mock_api_client.expect :get, "activity2", ["activity1"]
      @mock_result_parser.expect :parse, @expected, ["activity2"]
      activity = @connection.activity
      assert_equal @expected, activity
    end

    it "returns what reward details api reward detail" do
      @mock_url_helper.expect :reward, "reward1", [12]
      @mock_api_client.expect :get, "reward2", ["reward1"]
      @mock_result_parser.expect :parse, @expected, ["reward2"]
      reward = @connection.reward_detail 12
      assert_equal @expected, reward
    end

    it "returns what transaction details api transaction detail" do
      @mock_url_helper.expect :transaction, "transaction1", [12]
      @mock_api_client.expect :get, "transaction2", ["transaction1"]
      @mock_result_parser.expect :parse, @expected, ["transaction2"]
      transaction = @connection.transaction_detail 12
      assert_equal @expected, transaction
    end

    it "returns what card details api card detail" do
      @mock_url_helper.expect :card, "card1", [12]
      @mock_api_client.expect :get, "card2", ["card1"]
      @mock_result_parser.expect :parse, @expected, ["card2"]
      card = @connection.card_detail 12
      assert_equal @expected, card
    end

  end

  describe "defaults to JSON parser" do
    before do
      @url_helper = Object.new
      @api_client = Object.new
      @connection = Connection.new(@url_helper, @api_client)
      @expected = { "foo" => "bar" }
    end

    it "should use the JSON class for default parser" do
      assert_equal JSON, @connection.result_parser
    end

    it "returns an array of rewards" do
      def @url_helper.rewards; "rewards1"; end
      def @api_client.get(path); %q![ {"foo": "bar"} ]!; end

      result = @connection.rewards

      assert_equal [@expected], result
    end

    it "returns an array of transactions" do
      def @url_helper.transactions; "transactions1"; end
      def @api_client.get(path); %q![ {"foo": "bar"} ]!; end

      result = @connection.transactions

      assert_equal [@expected], result
    end

    it "returns an array of cards" do
      def @url_helper.cards; "cards1"; end
      def @api_client.get(path); %q![ {"foo": "bar"} ]!; end

      result = @connection.cards

      assert_equal [@expected], result
    end

    it "returns an hash of activity" do
      def @url_helper.activity; "activity1"; end
      def @api_client.get(path); %q! {"foo": "bar"} !; end

      result = @connection.activity

      assert_equal @expected, result
    end

  end
end