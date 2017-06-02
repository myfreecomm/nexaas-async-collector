# Nexaas::Async::Collector
Agnostic collector and generator of async content for Rails apps. Used in production in a few [Nexaas](www.nexaas.com) systems.

This gems is compatible with Ruby 2.1+ and Rails 3.2+.

## Prerequisites
The prerequisites of this project are:
  - Sidekiq 4+
  - Redis
  - JQuery 1.0+

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nexaas-async-collector'
```

And then run:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install nexaas-async-collector
```

## Usage
1) Create the file `config/initializers/nexaas-async-collector.rb` with the following content (edit as you need):

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
Bug reports and pull requests are welcome on GitHub at [https://github.com/myfreecomm/nexaas-async-collector](https://github.com/myfreecomm/nexaas-async-collector). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

After downloading the project and install all gems (through `bundler`) don't forget to install appraisal gems dependecies:

```
$ appraisal install
```

This is necessary to test the code in different versions of Ruby and Rails. To run the full suite of tests:

```
$ bundle exec rake spec
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
