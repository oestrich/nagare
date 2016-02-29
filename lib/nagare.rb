require 'active_support'
require 'active_support/core_ext'

module Nagare
  class Item
    def self._attributes
      @attributes ||= []
    end

    def self.attributes(*attributes)
      @attributes = _attributes.concat(attributes)

      attributes.each do |attribute|
        define_method(attribute) do
          if object.respond_to?(attribute)
            object.send(attribute)
          end
        end
      end
    end

    def initialize(object, context)
      @object = object
      @context = context
    end

    def attributes
      self.class._attributes.inject({}) do |hash, attribute|
        hash[attribute.to_s] = send(attribute)
        hash
      end.compact
    end

    def method_missing(key, *args)
      if context.respond_to?(key)
        context.send(key, *args)
      else
        super
      end
    end

    def as_json(options = nil)
      attributes
    end

    private

    attr_reader :object, :context
  end

  class Collection < Item
    include Enumerable

    def self._key
      @key || "items"
    end

    def self.key(key)
      @key = key
    end

    def self.attributes(*attributes)
      @attributes = _attributes.concat(attributes)
    end

    def initialize(collection, context, serializer:)
      @collection = collection
      @context = context
      @serializer = serializer
    end

    def each
      collection.map do |item|
        yield serializer.new(item, context)
      end
    end

    def as_json(options = nil)
      items = collection.map do |item|
        serializer.new(item, context).as_json
      end

      attributes.merge({
        self.class._key => items,
      })
    end

    private

    undef :object
    attr_reader :collection, :serializer
  end

  class Adapter
    def initialize(serializer)
      @serializer = serializer
    end

    def as_json(options = nil)
      serializer.as_json(options)
    end

    private

    attr_reader :serializer
  end

  class Context
    def initialize(attributes = {})
      @attributes = attributes
    end

    def extend(attributes)
      Context.new(@attributes.merge(attributes))
    end

    def respond_to?(key, private_methods = false)
      @attributes.has_key?(key) || super
    end

    def method_missing(method)
      if @attributes.has_key?(method)
        @attributes.fetch(method)
      else
        super
      end
    end
  end
end

require 'nagare/railtie' if defined?(Rails)
