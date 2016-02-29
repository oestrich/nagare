class Model < Struct.new(:id, :name)
end

class ModelSerializer < Nagare::Item
  attributes :id, :name, :extra

  def extra
    "extra"
  end
end

class ModelSerializer < Nagare::Item
  attributes :id, :name, :extra

  def extra
    "extra"
  end
end

class ModelsSerializer < Nagare::Collection
  key "models"

  attributes :extra

  def extra
    "extra"
  end
end
