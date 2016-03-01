# nagare

Nagare is a simple serializer for your Rails API.

## Installation

```ruby
gem 'nagare', github: 'oestrich/nagare'
```

## Usage

### Create your context

Create a specialized context for your application. Anything you place in here will be available inside of the serializers.

```ruby
class ApplicationController < ActionController::Base
  private
  
  def nagare_context
    @nagare_context ||= Nagare::Context.new({
      current_user: current_user,
    })
  end
end
```

### Create your serializers

There are item serializers and collection serializers.

```ruby
class OrderSerializer < Nagare::Item
  attributes :id, :user_id
end
```

You can access the object being serialized by the `object` method.

```ruby
class OrdersSerializer < Nagare::Collection
  attributes :count, :href
  
  def count
    collection.count
  end
end
```

You can access the collection being serialized by the `collection` method.

### Use your serializers

You can extend the context per route very easily by specifying a `context` key with a new hash. Hash keys will be available as methods inside of the serializer.

```ruby
class OrdersController < ApplicationController
  def index
    render({
      json: orders,
      serializers: { collection: OrdersSerializer, item: OrderSerializer },
      context: { href: orders_url },
    })
  end
  
  def show
    render({
      json: order,
      serializer: { item: OrderSerializer },
      context: { href: order_url(order) },
    })
  end
end
```

