module AmazonMerchant
  class ApiError < AmazonMerchant::Response

    def code
      content_at('ErrorResponse Error Code')
    end

    def message
      content_at('ErrorResponse Error Message')
    end

    def to_s
      "[#{code}] #{message}"
    end

  end
end