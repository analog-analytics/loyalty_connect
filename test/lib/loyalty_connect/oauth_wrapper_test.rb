require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe "OauthWrapper" do
    it "should obtain a token via password workflow of oauth2" do
      configuration = {
        'client_id'     => "client_id",
        'client_secret' => "client_secret",
        'server'        => "server",
        'username'      => "username",
        'password'      => "password"
      }
      expected = Object.new
      mock_password_workflow = MiniTest::Mock.new
      mock_password_workflow.expect :get_token, expected, ["username", "password"]
      mock_client = MiniTest::Mock.new
      mock_client.expect :password, mock_password_workflow
      mock_client_creator = MiniTest::Mock.new
      mock_client_creator.expect :new, mock_client, ["client_id", "client_secret", :site => "server"]

      wrapper = OauthWrapper.new configuration, mock_client_creator
      result_token = wrapper.oauth_token

      mock_client_creator.verify
      mock_client.verify
      mock_password_workflow.verify
      assert_same expected, result_token
    end

  end
end
