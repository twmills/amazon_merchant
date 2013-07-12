module AmazonMerchant::FeedRequests
  class OrderFulfillment

    attr_accessor :data

    def initialize(data = {})
      @data = data
    end

    def to_xml
      builder.to_xml
    end

    def builder
      Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
        xml.send('AmazonEnvelope', 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance", 'xsi:noNamespaceSchemaLocation' => "amzn-envelope.xsd") {
          build_header(xml)
          xml.MessageType "OrderFulfillment"
          orders.each_with_index { |order, i| build_message(xml, i + 1, order) }
        }
      end
    end

    def build_header(xml)
      xml.Header {
        xml.DocumentVersion "1.01"
        xml.MerchantIdentifier self.merchant_id
      }
    end

    def build_message(xml, messsage_id, order)
      xml.Message {
        xml.MessageID messsage_id
        xml.OrderFulfillment {
          xml.MerchantOrderID "123312"
          xml.MerchantFulfillmentID "1234"
          xml.FulfillmentDate "2002-05-01T15:36:33-08:00"
          xml.FulfillmentData {
            xml.CarrierCode "123312"
            xml.ShippingMethod "123312"
            xml.ShipperTrackingNumber "123312"
          }
          [*order[:items]].compact.each { |item| build_item(xml, item) }
        }
      }
    end

    def build_item(xml, item)
      xml.Item {
        xml.MerchantOrderItemID "123312"
        xml.MerchantFulfillmentItemID "1234"
        xml.Quantity "1"
      }
    end

    def orders
      data[:orders]
    end

    def merchant_id
      data[:merchant_id]
    end

  end
end