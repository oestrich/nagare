require 'spec_helper'

describe Serializer::Item do
  let(:model) { Model.new(10, "name") }
  let(:context) { Serializer::Context.new }
  let(:serializer) { ModelSerializer.new(model, context) }

  specify "as_json includes all attributes" do
    expect(serializer.as_json).to eq({
      "id" => 10,
      "name" => "name",
      "extra" => "extra",
    })
  end

  specify "can use the context" do
    context = Serializer::Context.new(:user => "user")
    serializer = ModelSerializer.new(model, context)

    expect(serializer.user).to eq("user")
  end

  specify "passes on methods to sub model" do
    expect(serializer.id).to eq(10)
    expect(serializer.name).to eq("name")
  end

  specify "includes its own methods in the json" do
    expect(serializer.extra).to eq("extra")
    expect(serializer.as_json["extra"]).to eq("extra")
  end
end
