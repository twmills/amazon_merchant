module AmazonMerchant
  class Connection

    class << self

      attr_writer :adapter

      def get(command, params = {})
        response = self.api_connection.get(UrlBuilder.uri(command, params))
        self.parse_response(response)
      end

      def api_connection
        adapter.connection(UrlBuilder.domain)
      end

      def adapter
        @adapter || AmazonMerchant::FaradayAdapter
      end

      def parse_response(response)
        case response.status
          when 409 then
            raise AmazonMerchant::PermissionError, response.body
          when 404 then
            nil
          when 200 then
            JSON.parse(response.body)
          when 501 then
            raise AmazonMerchant::NotImplementedError, response.body
        end
      end

    end

  end
end