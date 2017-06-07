$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nexaas/async/collector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nexaas-async-collector"
  s.version     = Nexaas::Async::Collector::VERSION
  s.authors     = ["Eduardo Hertz"]
  s.email       = ["eduardohertz@gmail.com"]
  s.homepage    = "https://github.com/myfreecomm/nexaas-async-collector"
  s.summary     = "Collect and generate async content."
  s.description = "Agnostic collector and generator of async content for Rails apps."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "sidekiq", "~> 4.2"
  s.add_dependency "redis-namespace", "1.5.2"

  s.add_development_dependency "sqlite3", "1.3.13"
  s.add_development_dependency "rspec", "3.6.0"
  s.add_development_dependency "rspec-rails", "3.6.0"
  s.add_development_dependency "appraisal", "2.2.0"
  s.add_development_dependency "fakeredis", "0.6.0"
  s.add_development_dependency "byebug", "9.0.6"
end
