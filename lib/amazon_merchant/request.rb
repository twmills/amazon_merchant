require 'time'

# This class handles the HTTP interactions with the MWS API calls.
module AmazonMerchant
  class Request

    attr_accessor :params, :method, :namespace, :version, :body

    def initialize(params = {})
      @method = params.delete(:method) || :get
      @namespace = params.delete(:namespace)
      @version = params[:version]
      @params = params.merge(private_params)
      parse_params!
      sort_params!
    end

    def connect!
      AmazonMerchant::Connection.send(method, self)
    end

    def domain
      "mws.amazonservices.com"
    end

    def protocol
      "https://"
    end

    def signature
      AmazonMerchant::Signature.create(method, domain, uri, query_string)
    end

    def signed_uri_with_query_string
      "#{uri}?#{query_string("Signature" => signature)}"
    end

    def uri
      namespace.nil? ? "/" : "/#{namespace}/#{version}"
    end

    def md5_body_signature
      Base64.encode64(Digest::MD5.new.digest(body)).strip
    end

    def query_string(extra_params = {})
      Rack::Utils.build_query(params.merge(extra_params))
    end

    def to_s
      "#{protocol}#{domain}#{signed_uri_with_query_string}"
    end

    def private_params
      params = {}
      params[:aws_access_key_id] = AmazonMerchant.access_key_id
      params[:signature_method] = "HmacSHA256"
      params[:signature_version] = "2"
      params[:timestamp] = Time.now.iso8601
      params
    end

    private

    def parse_params!
      self.params = params.inject({}) do |result, (k, v)|
        parse_param!(k, v, result)
        result
      end
    end

    def parse_param!(key, value, result)
      key = AmazonMerchant::String.camelize(key).sub(/Aws/,'AWS').sub(/Asin/,'ASIN')

      if value.is_a?(Hash)
        value.each do |subkey, v|
          subkey = AmazonMerchant::String.camelize(subkey).sub(/Asin/,'ASIN')
          key = "#{key}.#{subkey}"
          if v.is_a?(Array)
            v.each_with_index { |v2, i| result["#{key}.#{i + 1}"] = v2 }
          else
            result["#{key}.1"] = v
          end
        end
      else
        result[key] = value
      end
    end

    def transform_key(key)
      AmazonMerchant::String.camelize(key).sub(/Aws/,'AWS')
    end

    def sort_params!
      self.params = params.sort.inject({}) do |result, array|
        result[array.first] = array.last; result
      end
    end

  end
end