module AmazonMerchant
  class OrderItem < AmazonMerchant::Response

    map_attributes  id: 'OrderItemId',
                    order_item_id: 'OrderItemId',
                    asin: 'ASIN',
                    sku: 'SellerSKU',
                    title: 'Title',
                    quantity: 'QuantityOrdered',
                    quantity_ordered: 'QuantityOrdered',
                    quantity_shipped: 'QuantityShipped',
                    item_price: 'ItemPrice Amount',
                    item_tax: 'ItemTax Amount',
                    shipping_price: 'ShippingPrice Amount',
                    shipping_tax: 'ShippingTax Amount',
                    condition_id: 'ConditionId',
                    condition_subtype_id: 'ConditionSubtypeId',
                    condition_note: 'ConditionNote'

  end
end