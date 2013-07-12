module AmazonMerchant
  class Signature

    def self.create(method, domain, uri, query_string)
      canonical = [method.to_s.upcase, domain, uri, query_string].join("\n")
      puts canonical.inspect
      Base64.encode64(OpenSSL::HMAC.digest(self.digest, self.key, canonical)).chomp
    end

    def self.digest
      OpenSSL::Digest::Digest.new('sha256')
    end

    def self.key
      AmazonMerchant.secret_key
    end

  end
end