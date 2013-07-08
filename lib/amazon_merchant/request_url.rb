# This class handles the HTTP interactions with the MWS API calls.
module AmazonMerchant
  class RequestUrl

    attr_accessor :params, :method, :uri

    def initialize(params = {})
      @method = params.delete(:method) || :post
      @params = params.merge(private_params)
      camelize_params!
      sort_params!
    end

    def domain
      "https://mws.amazonservices.com"
    end

    def signature
      AmazonMerchant::Signature.create(method, domain, query_string)
    end

    def signed_query_string
      query_string("Signature" => signature)
    end

    def query_string(extra_params = {})
      Rack::Utils.build_query(params.merge(extra_params))
    end

    def to_s
      "#{domain}/#{signed_query_string}"
    end

    def private_params
      params = {}
      params[:aws_access_key_id] = AmazonMerchant.access_key_id
      params[:signature_method] = "HmacSHA256"
      params[:signature_version] = "2"
      params[:timestamp] = Time.now
      params[:version] = AmazonMerchant.version
      params
    end

    private

    def camelize_params!
      self.params = params.inject({}) do |result, (k, v)|
        result[AmazonMerchant::String.camelize(k).sub(/Aws/,'AWS')] = v; result
      end
    end

    def sort_params!
      self.params = params.sort.inject({}) do |result, array|
        result[array.first] = array.last; result
      end
    end

  end
end