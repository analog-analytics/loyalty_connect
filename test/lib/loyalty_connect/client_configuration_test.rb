require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ClientConfiguration do

    before do
      @params = {
        'server'=>'server1',
        'client_id' => 'client_id2',
        'client_secret' => 'client_secret3',
        'username'=>'username4',
        'password'=>'password5'
      }
    end

    it "gets server value from YAML" do
      configuration = ClientConfiguration.new @params
      assert_equal 'server1', configuration.server
    end

    it "gets client_id value from YAML" do
      configuration = ClientConfiguration.new @params
      assert_equal 'client_id2', configuration.client_id
    end

    it "gets client_secret value from YAML" do
      configuration = ClientConfiguration.new @params
      assert_equal 'client_secret3', configuration.client_secret
    end

    it "gets username value from YAML" do
      configuration = ClientConfiguration.new @params
      assert_equal 'username4', configuration.username
    end

    it "gets password value from YAML" do
      configuration = ClientConfiguration.new @params
      assert_equal 'password5', configuration.password
    end

    it "should make a new connection for a consumer" do
      expected = Object.new
      consumer_model = Object.new
      fake_wrapper = Object.new
      fake_token = Object.new
      fake_helper = Object.new
      fake_accessor = Object.new
      configuration = nil
      class << fake_wrapper
        attr_accessor :oauth_token
      end
      fake_wrapper.oauth_token = fake_token
      wrapper_validate = lambda do |config|
        assert_same configuration, config
        fake_wrapper
      end
      helper_validate = lambda do |model|
        assert_same consumer_model, model
        fake_helper
      end
      client_validate = lambda do |oauth_token|
        assert_same fake_token, oauth_token
        fake_accessor
      end
      connection_validate = lambda do |url_helper, app_accessor|
        assert_same fake_helper, url_helper
        assert_same fake_accessor, app_accessor
        expected
      end
      OauthWrapper.stub(:new, wrapper_validate) do
        ApiClient.stub(:new, client_validate) do
          UrlHelper.stub(:new, helper_validate) do
            Connection.stub(:new, connection_validate) do
              configuration = ClientConfiguration.new @params
              result = configuration.connection_for consumer_model
              assert_same expected, result
            end
          end
        end
      end
    end

    def inline_yaml_file
      result =<<-EOL
      bar:
        server:        "server1"
      client_id:     "client_id2"
      client_secret: "client_secret3"
      username:      "username4"
      password:      "password5"
      EOL
      result
    end

  end
end
