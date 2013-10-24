module LoyaltyConnect
  module Model
    class Card < Struct.new(:id, :url, :last_4, :brand, :bank, :brand_string, :country)
      class << self
        def from_json_hash(json_hash)
          data = json_hash || {}
          Card.new(
            data['id'],
            data['url'],
            data['last_4'],
            data['brand'],
            data['bank'],
            data['brand_string'],
            data['country']
          )
        end

        def from_paged_json(source)
          PagedItems.from_json_hash(source, "credit_cards") do |card|
            from_json_hash(card)
          end
        end
      end
    end
  end
end
