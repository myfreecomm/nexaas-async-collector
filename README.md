# Nexaas::Async::Collector
Agnostic collector and generator of async content for Rails apps. Used in production in a few [Nexaas](www.nexaas.com) systems.

This gems is compatible with Ruby 2.1+ and Rails 3.2+.

## Prerequisites
To work properly, your project must have (for now):
  - Sidekiq v4+
  - Redis

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nexaas-async-collector'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install nexaas-async-collector
```

## Usage
1) Create the file `config/initializers/nexaas-async-collector.rb` with the following content:

```ruby
  Nexaas::Async::Collector.configure do |config|
    # Your redis URL. The default value will be the value of yout REDIS_URL env var
    config.redis_url = "redis://test.local"

    # The namespace where you want to store you data within Redis
    config.redis_namespace = 'nexaas_async'

    # The method that returns the use robject (or anyother object you want. It must respond to id method)
    config.scope = :current_user

    # The parent class of all nexaas-async-collector controller
    config.parent_controller = "::ActionController::Base"
  end
```

2) Use the view helper to do all the process:

```ruby
<%= nexaas_async_collector(user.id, ModelService, :model_method, [arg1, arg2]) %>
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
