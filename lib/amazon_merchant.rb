require "amazon_merchant/version"

require 'base64'
require 'rack'
require 'openssl'
require 'nokogiri'
require 'amazon_merchant/configuration'
require 'amazon_merchant/connection'
require 'amazon_merchant/response'
require 'amazon_merchant/response_collection'
require 'amazon_merchant/api_error'
require 'amazon_merchant/faraday_adapter'
require 'amazon_merchant/order'
require 'amazon_merchant/order_collection'
require 'amazon_merchant/order_item'
require 'amazon_merchant/order_item_collection'
require 'amazon_merchant/product'
require 'amazon_merchant/feed_requests/order_fulfillment'
require 'amazon_merchant/request'
require 'amazon_merchant/submit_feed_result'
require 'amazon_merchant/service_status'
require 'amazon_merchant/signature'
require 'amazon_merchant/string'
require 'amazon_merchant/api'

module AmazonMerchant
  class << self

    attr_accessor :configuration

    def configure
      configuration = AmazonMerchant::Configuration.new
      yield(configuration)
      self.configuration = configuration
    end

    [:version, :access_key_id, :secret_key].each do |m|
      define_method m do
        self.configuration.send(m)
      end
    end

  end

  class Error < StandardError; end
  class NotFoundError < Error; end
  class PermissionError < Error; end
  class ValidationError < Error; end
  class UnknownResponse < Error; end
  class RequestThrottledError < Error; end
  class ServiceUnavailableError < Error; end

end
