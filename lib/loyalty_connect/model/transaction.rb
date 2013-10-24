module LoyaltyConnect
  module Model
    class Transaction < Struct.new(:id, :url, :merchant_name, :purchase_date, :brand, :last_4, :status, :amount, :currency, :reward_amount)
      class << self
        def from_json_hash(json_hash)
          data = json_hash || {}
          Transaction.new(
            data['id'],
            data['url'],
            (data['merchant'] || {})['name'],
            data['purchaseDate'],
            (data['creditCard'] || {})['brand'],
            (data['creditCard'] || {})['last_4'],
            data['status'],
            data['amount'].to_f / 100.0,
            data['currency'],
            data['rewardAmount'].to_f / 100.0
          )
        end

        def from_paged_json(source)
          PagedItems.from_json_hash(source, "transactions") do |transaction|
            from_json_hash(transaction)
          end
        end
      end
    end
  end
end
