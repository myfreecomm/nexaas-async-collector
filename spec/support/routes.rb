RSpec.configure do |config|
  config.before :each, type: :helper do
    helper.class.include Rails.application.routes.url_helpers
  end
end
