module AmazonMerchant
  class ResponseCollection < AmazonMerchant::Response

    include Enumerable

    attr_accessor :collection

    def initialize(response)
      super
      parse_collection!
    end

    def each(&block)
      collection.each do |item|
        block.call(item)
      end
    end

    def next_token
      content_at("#{self.class.root} NextToken")
    end

    def self.define_class_name(name)
      @class_name = name
    end

    def self.define_path(path)
      @path = path
    end

    def self.define_root(root)
      @root = root
    end

    def self.path
      @path
    end

    def self.root
      @root
    end

    def self.class_name
      @class_name
    end

    def parse_collection!
      node = document.at_css("#{self.class.path}")
      class_name = self.class.class_name
      klass = Object.const_get("AmazonMerchant::#{class_name}")

      self.collection = node.children.collect do |order_xml|
        klass.new(order_xml.to_xml) if order_xml.name == class_name
      end.compact unless node.nil?
    end
  end
end