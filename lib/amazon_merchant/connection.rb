module AmazonMerchant
  class Connection

    class << self

      attr_writer :adapter

      [:get, :post].each do |http_method|
        define_method http_method do |request|
          response = self.adapter(request).send(http_method)
          self.parse_response(response)
        end
      end

      def adapter(request)
        @adapter || AmazonMerchant::FaradayAdapter.new(request)
      end

      def parse_response(response)
        case response.status
          when 400 then
            raise AmazonMerchant::ValidationError, parse_error(response.body)
          when 200 then
            response.body
          when 503 then
            handle_503(response)
          else
            raise AmazonMerchant::UnknownResponse, response.body
        end
      end

      def parse_error(xml)
        AmazonMerchant::ApiError.new(xml).to_s
      end

      def handle_503(response)
        api_error = AmazonMerchant::ApiError.new(response.body)
        error_class = api_error.code == "RequestThrottled" ? AmazonMerchant::RequestThrottledError : AmazonMerchant::ServiceUnavailable
        raise error_class, api_error.to_s
      end

    end

  end
end