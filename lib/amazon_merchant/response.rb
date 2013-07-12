module AmazonMerchant
  class Response

    attr_accessor :document

    def initialize(response)
      @document = Nokogiri::XML(response).remove_namespaces!
    end

    def self.map_attributes(attr_map = {})
      @attr_map = attr_map
      attr_map.each do |attr, path|
        define_method(attr)  do
          content_at(path)
        end
      end
    end

    def self.attr_map
      @attr_map
    end

    def content_at(path)
      node = document.at_css(path)
      node.content unless node.nil?
    end

    def to_hash
      hash = {}
      self.class.attr_map.keys.each do |attr|
        hash[attr] = send(attr)
      end
      hash
    end

  end
end