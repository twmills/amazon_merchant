module AmazonMerchant
  class Product < AmazonMerchant::Response

    map_attributes  weight: 'AttributeSets ItemAttributes ItemDimensions Weight',
                    list_price: 'AttributeSets ItemAttributes ListPrice Amount',
                    currency_code: 'AttributeSets ItemAttributes ListPrice CurrencyCode'


  end
end