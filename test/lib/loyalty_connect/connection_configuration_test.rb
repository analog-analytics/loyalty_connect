require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  describe ConnectionConfiguration do

    it "gets server value from YAML" do
      ::File.stub(:open, inline_yaml_file) do
        configuration = ConnectionConfiguration.new "foo", "bar"
        assert_equal 'server1', configuration.server
      end
    end

    it "gets client_id value from YAML" do
      ::File.stub(:open, inline_yaml_file) do
        configuration = ConnectionConfiguration.new "foo", "bar"
        assert_equal 'client_id2', configuration.client_id
      end
    end

    it "gets client_secret value from YAML" do
      ::File.stub(:open, inline_yaml_file) do
        configuration = ConnectionConfiguration.new "foo", "bar"
        assert_equal 'client_secret3', configuration.client_secret
      end
    end

    it "gets username value from YAML" do
      ::File.stub(:open, inline_yaml_file) do
        configuration = ConnectionConfiguration.new "foo", "bar"
        assert_equal 'username4', configuration.username
      end
    end

    it "gets password value from YAML" do
      ::File.stub(:open, inline_yaml_file) do
        configuration = ConnectionConfiguration.new "foo", "bar"
        assert_equal 'password5', configuration.password
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
