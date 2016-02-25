require 'spec_helper'

describe Serializer::Collection do
  let(:model) { Model.new(10, "name") }
  let(:context) { Serializer::Context.new }

  let(:serializer) { ModelsSerializer.new([model], context, serializer: ModelSerializer) }

  specify "loads items as json" do
    expect(serializer.as_json).to eq({
      "extra" => "extra",
      "models" => [
        {
          "id" => 10,
          "name" => "name",
          "extra" => "extra",
        },
      ]
    })
  end

  specify "loads each item" do
    expect(serializer.count).to eq(1)
    serializer.each do |item_serializer|
      expect(item_serializer).to be_a(ModelSerializer)
      expect(item_serializer.id).to eq(10)
    end
  end

  specify "has access to the context" do
    context = Serializer::Context.new(:user => "user")
    serializer = ModelsSerializer.new([model], context, serializer: ModelSerializer)

    expect(serializer.user).to eq("user")
  end

  specify "can have attributes" do
    expect(serializer.extra).to eq("extra")
    expect(serializer.as_json["extra"]).to eq("extra")
  end
end
