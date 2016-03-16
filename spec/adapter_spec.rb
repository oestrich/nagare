require 'spec_helper'

describe Nagare::Adapter do
  let(:model) { Model.new(10, "name") }
  let(:context) { Nagare::Context.new }
  let(:serializer) { ModelsSerializer.new([model], context, serializer: ModelSerializer) }

  let(:adapter) { Nagare::Adapter.new(serializer) }

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

  specify "allows hint that serializer is a collection" do
    adapter = Nagare::Adapter.new(serializer, collection: true)
    expect(adapter.send(:collection)).to be_truthy
  end
end
