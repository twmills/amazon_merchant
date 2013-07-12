module AmazonMerchant
  class OrderItemCollection < AmazonMerchant::ResponseCollection
    define_root 'ListOrderItemsResult'
    define_path 'OrderItems'
    define_class_name 'OrderItem'
  end
end