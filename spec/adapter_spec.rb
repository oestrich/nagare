require 'spec_helper'

describe Serializer::Adapter do
  let(:model) { Model.new(10, "name") }
  let(:context) { Serializer::Context.new }
  let(:serializer) { ModelsSerializer.new([model], context, serializer: ModelSerializer) }

  let(:adapter) { Serializer::Adapter.new(serializer) }

  specify "forwards as json directly to the serializer" do
    expect(adapter.as_json).to eq({
      "extra" => "extra",
      "models" => [
        {
          "id" => 10,
          "name" => "name",
          "extra" => "extra",
        },
      ],
    })
  end
end
