# Configuration class that stores configuration options for the AmazonMerchant API.
#
# Configuration options are typically set via the MWSOrders.config method.
# @see AmazonMerchant.configure
# @example
#   AmazonMerchant.configure do |config|
#     config.access_key_id = "12345"
#     config.secret_key = "XXXXXXXXXXXXXXXXXXXXXXXX"
#   end
module AmazonMerchant
  class Configuration
    attr_accessor :access_key_id, :secret_key, :version

    def initialize
      @version = "2011-01-01"
    end

  end
end