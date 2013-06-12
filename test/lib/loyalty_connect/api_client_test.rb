require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  TestConfiguration = Struct.new :client_id, :client_secret, :server, :username, :password

  describe ApiClient do

    it "should create obtain a token via password workflow of oauth2" do
      configuration = TestConfiguration.new("client_id", "client_secret", "server", "username", "password")
      expected = Object.new
      mock_token = MiniTest::Mock.new
      mock_token.expect :token_param=, nil, ['access_token']
      mock_token.expect :get, expected, ["blah"]
      mock_password = MiniTest::Mock.new
      mock_password.expect :get_access_token, mock_token, ["username", "password"]
      mock_client = MiniTest::Mock.new
      mock_client.expect :password, mock_password
      client_handler = lambda do |id, secret, options|
        assert_equal "client_id", id
        assert_equal "client_secret", secret
        assert_equal "server", options[:site]
        assert_equal "/oauth/token", options[:access_token_path]
        mock_client
      end
      OAuth2::Client.stub(:new, client_handler) do
        client = ApiClient.new configuration
        result = client.get "blah"
        assert_same expected, result
      end
      mock_client.verify
      mock_token.verify
      mock_password.verify
    end

  end
end
