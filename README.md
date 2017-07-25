# Nexaas::Async::Collector

[![Build Status](https://travis-ci.org/myfreecomm/nexaas-async-collector.svg?branch=master)](https://travis-ci.org/myfreecomm/nexaas-async-collector)
[![Test Coverage](https://codeclimate.com/github/myfreecomm/nexaas-async-collector/badges/coverage.svg)](https://codeclimate.com/github/myfreecomm/nexaas-async-collector/coverage)
[![Code Climate](https://codeclimate.com/github/myfreecomm/nexaas-async-collector/badges/gpa.svg)](https://codeclimate.com/github/myfreecomm/nexaas-async-collector)


Agnostic collector and generator of async content for Rails apps. Used in production in a few [Nexaas](www.nexaas.com) systems.

This gems is compatible with Ruby 2.3+ and Rails 3.2+.

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

    # The name of the sidekiq queue to be used
    config.queue_name = :high_fast

    # The method that returns the user object (or any other object you want. It must respond to id method)
    config.scope = :current_user

    # The parent class of all nexaas-async-collector controller
    config.parent_controller = "::ActionController::Base"
  end
```

2) Add this to your *config/routes.rb* file:

```ruby
Rails.application.routes.draw do
  # ...
  mount Nexaas::Async::Collector::Engine => '/nexaas_async_collect'
  # ...
end
```

3) Use the view helper to do all the process:

```ruby
<%= nexaas_async_collect({
  scope_id: scope.id, # (required) the ID of the scope. It ensures only the scope who requested the data will be able to fetch it
  class_name: ModelService, # (required) name of the class
  class_method: :model_method, # (required) name of the class method responsible to generate data
  args: [arg1, arg2], # (optional) arguments to be passed to class method
  instrumentation_context: 'my.custom.instrumentation' # (optional) context of the instrumentation name. It will generate two instrumentation: 'my.custom.instrumentation.start' and 'my.custom.instrumentation.finish'
}) %>
```

### Download file

Instead of rendering text or HTML, you can use `nexaas-async-collect` to generate files, so the user can download it.

If you want to export something to `xls` file, for example:

```ruby
<%= nexaas_async_collect({
  scope_id: scope.id, # (required)
  class_name: ModelService, # (required)
  class_method: :model_method, # (required)
  args: [arg1, arg2], # (optional)
  file: {
    content_type: 'application/vnd.ms-excel', # (required) content type of the file
    name: 'reports', # (required) name of the file
    extension: 'xls' # (require) extension of the file
  }
}) %>
```

This will generate the spinner and it will redirect the user to download the file when it is ready.

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/myfreecomm/nexaas-async-collector](https://github.com/myfreecomm/nexaas-async-collector). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

After downloading the project and install all gems (through `bundler`) don't forget to install appraisal gems dependencies:

```
$ appraisal install
```

This is necessary to test the code in different versions of Ruby and Rails. To run the full suite of tests:

```
$ appraisal rake spec
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
