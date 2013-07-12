module AmazonMerchant
  class Order < AmazonMerchant::Response

    map_attributes  id: 'AmazonOrderId',
                    amazon_order_id: 'AmazonOrderId',
                    amount: 'OrderTotal Amount',
                    phone: 'ShippingAddress Phone',
                    address_name: 'ShippingAddress Name',
                    address_line_1: 'ShippingAddress AddressLine1',
                    address_line_2: 'ShippingAddress AddressLine2',
                    city: 'ShippingAddress City',
                    state: 'ShippingAddress StateOrRegion',
                    country_code: 'ShippingAddress CountryCode',
                    buyer_email: 'BuyerEmail',
                    buyer_name: 'BuyerName',
                    order_status: 'OrderStatus',
                    purchase_date: 'PurchaseDate',
                    order_type: 'OrderType'

  end
end