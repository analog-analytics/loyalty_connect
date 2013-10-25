require "test_helper"
require "loyalty_connect"

module LoyaltyConnect
  module Model
    describe CreateUserResult do

      it "succeeds if no errors" do
        json = { 'consumer' => { 'url' => "someplace" } }
        result = CreateUserResult.from_json_hash(json)
        result.success?.must_equal true
      end

      it "fails if nil response" do
        json = nil
        result = CreateUserResult.from_json_hash(json)
        result.success?.must_equal false
        result.messages.must_equal ["No response"]
      end

      it "fails if missing consumer" do
        json = Hash.new
        result = CreateUserResult.from_json_hash(json)
        result.success?.must_equal false
        result.messages.must_equal ["Malformed response"]
      end

      it "fails if missing url" do
        json = { "consumer" => Hash.new }
        result = CreateUserResult.from_json_hash(json)
        result.success?.must_equal false
        result.messages.must_equal ["Malformed response"]
      end

      it "fails if have error messages" do
        json = { "errors" => ["error1", "error2"] }
        result = CreateUserResult.from_json_hash(json)
        result.success?.must_equal false
        result.messages.must_equal ["error1", "error2"]
      end
    end
  end
end
