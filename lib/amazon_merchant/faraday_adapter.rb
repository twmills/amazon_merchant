# This class handles the HTTP interactions with the MWS API calls.
module AmazonMerchant
  class FaradayAdapter

    attr_accessor :request

    def initialize(request)
     @request = request
    end

    def get
      connection.get request.signed_uri_with_query_string
    end

    def post
      connection.post do |req|
        req.url request.signed_uri_with_query_string
        req.headers['Content-MD5'] = request.md5_body_signature
        req.body = request.body
      end
    end

    def connection
      Faraday.new(:url => "#{request.protocol}#{request.domain}") do |faraday|
        faraday.response :logger # log requests to STDOUT
        faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
      end
    end
  end
end