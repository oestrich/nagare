require 'spec_helper'

describe Nagare::Item do
  let(:model) { Model.new(10, "name") }
  let(:context) { Nagare::Context.new(href: "href") }
  let(:serializer) { ModelSerializer.new(model, context) }

  specify "as_json includes all attributes" do
    expect(serializer.as_json).to eq({
      "id" => 10,
      "name" => "name",
      "extra" => "extra",
      "href" => "href",
    })
  end

  specify "can use the context" do
    context = Nagare::Context.new(:user => "user")
    serializer = ModelSerializer.new(model, context)

    expect(serializer.user).to eq("user")
  end

  specify "includes context if an attribute in the json" do
    expect(serializer.as_json["href"]).to eq("href")
  end

  specify "passes on methods to sub model" do
    expect(serializer.id).to eq(10)
    expect(serializer.name).to eq("name")
  end

  specify "includes its own methods in the json" do
    expect(serializer.extra).to eq("extra")
    expect(serializer.as_json["extra"]).to eq("extra")
  end

  specify "handles subclassing" do
    expect(SubModelSerializer._attributes).to eq([:id, :name, :extra])
  end
end
