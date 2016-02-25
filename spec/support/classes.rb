class Model < Struct.new(:id, :name)
end

class ModelSerializer < Serializer::Item
  attributes :id, :name, :extra

  def extra
    "extra"
  end
end

class ModelSerializer < Serializer::Item
  attributes :id, :name, :extra

  def extra
    "extra"
  end
end

class ModelsSerializer < Serializer::Collection
  key "models"

  attributes :extra

  def extra
    "extra"
  end
end
