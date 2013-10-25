module LoyaltyConnect
  module Model
    module CreateUserResult

      class SuccessResult
        def success?
          true
        end
      end

      class FailureResult
        def initialize(*messages)
          @messages = messages
        end

        def success?
          false
        end

        attr_reader :messages
      end

      NO_RESULT = { 'errors' => ['No response'], 'consumer' => {} }

      class << self
        def from_json_hash(json_hash)
          hash = json_hash || NO_RESULT
          error_messages = Array(hash['errors']).map(&:to_s)
          return FailureResult.new(*error_messages) if error_messages.any?
          consumer = hash['consumer']
          return FailureResult.new('Malformed response') if consumer.nil?
          url = consumer['url'].to_s
          return FailureResult.new('Malformed response') if url.empty?
          SuccessResult.new
        end
      end
    end
  end
end
