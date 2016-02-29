module Nagare
  module Controller
    private

    def nagare_adapter
      Nagare::Adapter
    end

    def nagare_context
      @nagare_context ||= Nagare::Context.new
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
          new(resource, nagare_context.extend(options.fetch(:context, {})), serializer: item_serializer)
      else
        item_serializer = serializers.fetch(:item)

        serializer = item_serializer.new(resource, nagare_context.extend(options.fetch(:context, {})))
      end

      super(nagare_adapter.new(serializer), options)
    end
  end

  class Railtie < Rails::Railtie
    initializer "nagare.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include Nagare::Controller
      end
    end
  end
end
