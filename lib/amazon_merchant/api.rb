module AmazonMerchant
  class Api

    attr_accessor :merchant_id

    def self.define_command(options = {})
      define_method options[:name] do |params = {}|
        common_params = { seller_id: merchant_id,
                          action: AmazonMerchant::String.camelize(options[:name]),
                          version: options[:version],
                          namespace: AmazonMerchant::String.camelize(options[:namespace]) }
        request = AmazonMerchant::Request.new(common_params.merge(params))
        options[:response_class].new(request.connect!)
      end
    end

    define_command name: :get_service_status, namespace: :orders, response_class: AmazonMerchant::ServiceStatus, version: '2011-01-01'
    define_command name: :list_orders, namespace: :orders, response_class: AmazonMerchant::OrderCollection, version: '2011-01-01'
    define_command name: :list_orders_by_next_token, namespace: :orders, response_class: AmazonMerchant::OrderCollection, version: '2011-01-01'
    define_command name: :list_order_items, namespace: :orders, response_class: AmazonMerchant::OrderItemCollection, version: '2011-01-01'
    define_command name: :list_order_items_by_next_token, namespace: :orders, response_class: AmazonMerchant::OrderItemCollection, version: '2011-01-01'
    define_command name: :get_matching_product, namespace: :products, response_class: AmazonMerchant::Product, version: '2011-10-01'

    def initialize(options = {})
      @merchant_id = options.delete(:merchant_id)
    end

    def product(params={})
      get_matching_product(params)
    end

    def orders(params={})
      if params.has_key?(:next_token)
        list_orders_by_next_token(params[:next_token])
      else
        list_orders(params)
      end
    end

    def order_items(params={})
      if params.has_key?(:next_token)
        list_order_items_by_next_token(params[:next_token])
      else
        list_order_items(params)
      end
    end

    def update_order_fulfillment(params = {})
      orders = params.delete(:orders)
      document = AmazonMerchant::FeedRequests::OrderFulfillment.new(orders: orders, merchant_id: merchant_id)


      common_params = { seller_id: merchant_id,
                        action: 'SubmitFeed',
                        version: "2009-01-01",
                        feed_type: '_POST_ORDER_FULFILLMENT_DATA_',
                        method: :post }

      request = AmazonMerchant::Request.new(common_params.merge(params))
      request.body = document.to_xml
      AmazonMerchant::SubmitFeedResult.new(request.connect!)
    end

    def authenticated?
      begin
        list_orders(created_after: (Time.now - 1000).iso8601, max_results_per_page: 1)
        true
      rescue AmazonMerchant::ValidationError
        false
      end
    end

  end
end