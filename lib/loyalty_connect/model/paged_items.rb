module LoyaltyConnect
  module Model
    class PagedItems < Struct.new(:previous_url, :current_url, :next_url, :items)
      class << self
        def from_json_hash(json_hash, items_name, &converter)
          data = json_hash || {}
          PagedItems.new(
            data['previous_uri'],
            data['current_uri'],
            data['next_uri'],
            Array(data[items_name]).map(&converter)
          )
        end
      end
    end
  end
end
