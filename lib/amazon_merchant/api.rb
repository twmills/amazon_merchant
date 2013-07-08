module AmazonMerchant
  class Api

    attr_accessor :merchant_id, :marketplace_id

    def initialize(options = {})
      @marchant_id = options.delete(:merchant_id)
      @marketplace_id = options.delete(:marketplace_id)
    end

  end
end