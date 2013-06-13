require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ApiClient do

    it "should return what the api returns" do
      stub_oauth_token = Class.new do
        def self.get url
          :something
        end
      end
      client = ApiClient.new stub_oauth_token
      result = client.get "blah"
      assert_equal :something, result
    end

    it "should return nil if get error from get" do
      stub_oauth_token = Class.new do
        def self.get url
          raise OAuth2::HTTPError, "404"
        end
      end
      client = ApiClient.new stub_oauth_token
      result = client.get "blah"
      assert_nil result
    end

  end
end
