require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  class MockApiClient
    def get_urls
      @get_urls ||= []
    end

    def get_block_values
      @get_block_values ||= []
    end

    def get url, block
      get_urls << url
      get_block_values << block.call
      :mock_api_client_get_return
    end

    def post_urls
      @post_urls ||= []
    end

    def post_options
      @post_options ||= []
    end

    def post_block_values
      @post_block_values ||= []
    end

    def post url, options, block
      post_urls << url
      post_options << options
      post_block_values << block.call
      :mock_api_client_post_return
    end
  end

  describe "connection" do
    let(:url_helper) { Minitest::Mock.new }
    let(:api_client) { MockApiClient.new }
    subject() { Connection.new url_helper, api_client }

    describe "rewards" do
      before do
        url_helper.expect(:rewards, :url_return)
      end

      it "uses the rewards URL" do
        subject.rewards
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.rewards
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty array" do
        subject.rewards
        api_client.get_block_values.must_include "[]"
      end
    end

    describe "transactins" do
      before do
        url_helper.expect(:transactions, :url_return)
      end

      it "uses the transactions URL" do
        subject.transactions
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.transactions
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty array" do
        subject.transactions
        api_client.get_block_values.must_include "[]"
      end
    end

    describe "cards" do
      before do
        url_helper.expect(:cards, :url_return)
      end

      it "uses the cards URL" do
        subject.cards
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.cards
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty array" do
        subject.cards
        api_client.get_block_values.must_include "[]"
      end
    end

    describe "activity" do
      before do
        url_helper.expect(:activity, :url_return)
      end

      it "uses the activity URL" do
        subject.activity
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.activity
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty hash" do
        subject.activity
        api_client.get_block_values.must_include "{}"
      end
    end

    describe "reward_detail" do
      before do
        url_helper.expect(:reward, :url_return, [12])
      end

      it "uses the reward URL" do
        subject.reward_detail(12)
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.reward_detail(12)
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty hash" do
        subject.reward_detail(12)
        api_client.get_block_values.must_include "{}"
      end
    end

    describe "transaction_detail" do
      before do
        url_helper.expect(:transaction, :url_return, [12])
      end

      it "uses the transaction URL" do
        subject.transaction_detail(12)
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.transaction_detail(12)
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty hash" do
        subject.transaction_detail(12)
        api_client.get_block_values.must_include "{}"
      end
    end

    describe "card_detail" do
      before do
        url_helper.expect(:card, :url_return, [12])
      end

      it "uses the card URL" do
        subject.card_detail(12)
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.card_detail(12)
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty hash" do
        subject.card_detail(12)
        api_client.get_block_values.must_include "{}"
      end
    end

    describe "register_user" do
      before do
        url_helper.expect(:create_user, :url_return)
      end

      it "uses the create_user URL" do
        subject.register_user
        url_helper.verify
        api_client.post_urls.must_include :url_return
      end

      it "calls post on the API client" do
        results = subject.register_user
        results.must_equal :mock_api_client_post_return
      end

      it "defaults to empty hash" do
        subject.register_user
        api_client.post_block_values.must_include "{}"
      end

      it "wraps options in a 'consumer' hash for the API post" do
        options = Object.new
        subject.register_user options
        consumer_hash = { :consumer => options }
        api_client.post_options.must_include consumer_hash
      end
    end

  end
end
