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

    def get url, &block
      get_urls << url
      error = LoyaltyConnect.error_for "404"
      get_block_values << block.call(error)
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

    def post url, options, &block
      post_urls << url
      post_options << options
      error = LoyaltyConnect.error_for "404"
      post_block_values << block.call(error)
      :mock_api_client_post_return
    end

    def delete_urls
      @delete_urls ||= []
    end

    def delete_options
      @delete_options ||= []
    end

    def delete_block_values
      @delete_block_values ||= []
    end

    def delete url, options, &block
      delete_urls << url
      delete_options << options
      error = LoyaltyConnect.error_for "404"
      delete_block_values << block.call(error)
      :mock_api_client_delete_return
    end

  end

  def self.error_for message
    Class.new do
      define_method(:message) { message }
    end.new
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
    end

    describe "delete_user" do
      before do
        url_helper.expect(:delete_user, :url_return)
      end

      it "uses the delete_user URL" do
        subject.delete_user
        url_helper.verify
        api_client.delete_urls.must_include :url_return
      end

      it "calls delete on the API client" do
        results = subject.delete_user
        results.must_equal :mock_api_client_delete_return
      end

      it "defaults to empty hash" do
        subject.delete_user
        api_client.delete_block_values.must_include "{}"
      end
    end

    describe "new_credit_card" do
      before do
        url_helper.expect(:new_credit_card, :url_return)
      end

      it "uses the new_credit_card URL" do
        subject.new_credit_card
        url_helper.verify
        api_client.get_urls.must_include :url_return
      end

      it "calls get on the API client" do
        results = subject.new_credit_card
        results.must_equal :mock_api_client_get_return
      end

      it "defaults to empty hash" do
        subject.new_credit_card
        api_client.get_block_values.must_include "{}"
      end
    end

    describe "create_credit_card" do
      let(:params) { Object.new }

      before do
        url_helper.expect(:create_credit_card, :url_return)
      end

      it "uses the create_credit_card URL" do
        subject.create_credit_card(params)
        url_helper.verify
        api_client.post_urls.must_include :url_return
      end

      it "calls post on the API client" do
        results = subject.create_credit_card(params)
        results.must_equal :mock_api_client_post_return
      end

      it "defaults to empty hash" do
        subject.create_credit_card(params)
        api_client.post_block_values.must_include "{}"
      end

      it "pass params to the API" do
        subject.create_credit_card(params)
        api_client.post_options.must_include params
      end
    end

    describe "delete_credit_card" do
      let(:params) { Object.new }

      before do
        url_helper.expect(:delete_credit_card, :url_return, [params])
      end

      it "uses the delete_credit_card URL" do
        subject.delete_credit_card(params)
        url_helper.verify
        api_client.delete_urls.must_include :url_return
      end

      it "calls delete on the API client" do
        results = subject.delete_credit_card(params)
        results.must_equal :mock_api_client_delete_return
      end

      it "defaults to empty hash" do
        subject.delete_credit_card(params)
        api_client.delete_block_values.must_include "{}"
      end

      it "pass params to the API" do
        subject.delete_credit_card(params)
        api_client.delete_options.must_include Hash.new
      end
    end
  end

  describe "exist?" do
    let(:url_helper) { Minitest::Mock.new }
    let(:api_client) do
      Class.new do
        attr_accessor :should_be_found
        def get _, &block
          error = LoyaltyConnect.error_for "404"
          block.call(error) unless should_be_found
          :exist_get_response
        end
      end.new
    end
    subject() { Connection.new url_helper, api_client }

    before do
      url_helper.expect(:show, :show_return)
    end

    it "uses the show url" do
      subject.exist?
      url_helper.verify
    end

    it "returns true if the consumer exists" do
      api_client.should_be_found = true
      assert subject.exist?
    end

    it "returns false if the consumer does not exists" do
      api_client.should_be_found = false
      refute subject.exist?
    end
  end

end
