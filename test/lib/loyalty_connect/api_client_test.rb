require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ApiClient do

    it "should return what the api returns converted to a string and trimmed" do
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

    it "should raise errors by default" do
      stub_oauth_token = Class.new do
        def self.get _, _, _
          raise OAuth2::HTTPError, "500"
        end
      end
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      assert_raises OAuth2::HTTPError do
        client.get "blah"
      end
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

    it "should call error handler on errors" do
      yield_args = []
      expected_exception = OAuth2::HTTPError.new("500")
      stub_oauth_token = Class.new do
        define_method(:get) do |_,_,_|
          raise expected_exception
        end
      end.new
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      client.get "blah" do |error|
        yield_args << error
      end
      assert_includes yield_args, expected_exception
    end

    def create_oauth_wrapper(token=nil)
      stub_oauth_wrapper = Class.new do
        define_method(:oauth_token) { token }
      end.new
    end
  end
end
