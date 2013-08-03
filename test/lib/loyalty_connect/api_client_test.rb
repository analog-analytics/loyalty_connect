require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ApiClient do

    it "should return what the api returns" do
      stub_oauth_token = Class.new do
        def self.get _, _, _
          :something
        end
      end
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      result = client.get "blah"
      assert_equal "something", result
    end

    it "should return nil if get error from get" do
      stub_oauth_token = Class.new do
        def self.get _, _, _
          raise OAuth2::HTTPError, "404"
        end
      end
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      result = client.get "blah"
      assert_nil result
    end

    it "should include the version header" do
      mock_token = Minitest::Mock.new
      mock_token.expect :get, nil do |_, _, headers|
        assert_includes headers.keys, 'X-API-Version'
        assert_equal '1.0.0', headers['X-API-Version']
      end
      stub_oauth_wrapper = create_oauth_wrapper(mock_token)
      client = ApiClient.new stub_oauth_wrapper
      result = client.get "blah"
      mock_token.verify
    end

    def create_oauth_wrapper(token=nil)
      stub_oauth_wrapper = Class.new do
        class << self
          attr_accessor :oauth_token
        end
      end
      stub_oauth_wrapper.oauth_token = token
      stub_oauth_wrapper
    end
  end
end
