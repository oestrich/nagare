module Serializer
  module Controller
    private

    def serializer_adapter
      Serializer::Adapter
    end

    def serializer_context
      @serializer_context ||= Serializer::Context.new
    end

    def _render_with_renderer_json(resource, options)
      serializers = options.fetch(:serializers, nil)

      if serializers.nil?
        return super(resource, options)
      end

      if resource.respond_to?(:each)
        collection_serializer = serializers.fetch(:collection)
        item_serializer = serializers.fetch(:item)

        serializer = collection_serializer.
          new(resource, serializer_context.extend(options.fetch(:context, {})), serializer: item_serializer)
      else
        item_serializer = serializers.fetch(:item)

        serializer = item_serializer.new(resource, serializer_context.extend(options.fetch(:context, {})))
      end

      super(serializer_adapter.new(serializer), options)
    end
  end

  class Railtie < Rails::Railtie
    initializer "serializer.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include Serializer::Controller
      end
    end
  end
end
