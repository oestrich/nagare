class Model
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end

class ModelSerializer < Nagare::Item
  attributes :id, :name, :extra

  def extra
    "extra"
  end
end

class SubModelSerializer < ModelSerializer
end

class ModelSerializer < Nagare::Item
  attributes :id, :name, :extra, :href

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

class ModelNilSerializer < Nagare::Item
  attributes :id, :name

  options nil: true
end

class SubModelNotNilSerializer < ModelNilSerializer
  options nil: false
end
