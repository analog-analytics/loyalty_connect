require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ApiClient do

    it "should return what the api returns converted to a string and trimmed" do
      stub_oauth_token = Class.new do
        def self.get *_
          Class.new do
            def to_s
              "       something        "
            end
          end.new
        end
      end
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      result = client.get "blah"
      assert_equal "something", result
    end

    it "should raise errors by default" do
      cache = self
      stub_oauth_token = Class.new do
        define_method(:get) do |*_|
          raise cache.create_error_for(500)
        end
      end.new
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      assert_raises OAuth2::Error do
        client.get "blah"
      end
    end

    it "should include the version header" do
      cache = self
      stub_oauth_token = Class.new do
        define_method(:get) do |_, _, headers|
          cache.assert_includes headers.keys, 'X-API-Version'
          cache.assert_equal '1.0.0', headers['X-API-Version']
        end
      end.new
      stub_oauth_wrapper = create_oauth_wrapper(stub_oauth_token)
      client = ApiClient.new stub_oauth_wrapper
      result = client.get "blah"
    end

    it "should call error handler on errors" do
      yield_args = []
      expected_exception = create_error_for(500, "bad stuff")
      stub_oauth_token = Class.new do
        define_method(:get) do |*_|
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

    def create_error_for(code, message="")
      stub_response = Class.new do
        attr_accessor :error, :parsed, :body
      end.new
      stub_response.parsed = {
        'error' => code,
        'error_description' => message
      }
      OAuth2::Error.new(stub_response)
    end

  end
end
