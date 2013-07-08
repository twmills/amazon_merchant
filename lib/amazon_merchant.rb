require "amazon_merchant/version"

require 'base64'
require 'rack'
require 'openssl'
require 'amazon_merchant/configuration'
require 'amazon_merchant/request_url'
require 'amazon_merchant/signature'

module AmazonMerchant
  class << self

    attr_accessor :configuration

    def configure
      configuration = AmazonMerchant::Configuration.new
      yield(configuration)
      self.configuration = configuration
    end

    [:version, :access_key_id, :secret_key].each do |m|
      define_singleton_method m do
        self.configuration.send(m)
      end
    end

  end

  class Error < StandardError; end
  class NotFoundError < Error; end
  class PermissionError < Error; end
end
