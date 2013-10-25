module LoyaltyConnect
  module Model
    class Reward < Struct.new(:id, :url, :rewarded_at, :rewarded_amount)
      class << self
        def from_json_hash(json_hash)
          data = json_hash || {}
          Reward.new(
            data['id'],
            data['url'],
            data['rewarded_at'],
            data['rewarded_amount'].to_f / 100.0
          )
        end

        def from_paged_json(source)
          PagedItems.from_json_hash(source, "rewards") do |reward|
            from_json_hash(reward)
          end
        end
      end
    end
  end
end
