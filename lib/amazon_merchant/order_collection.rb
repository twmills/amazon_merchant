module AmazonMerchant
  class OrderCollection < AmazonMerchant::ResponseCollection
    define_class_name 'Order'
    define_root 'ListOrdersResult'
    define_path 'Orders'
  end
end