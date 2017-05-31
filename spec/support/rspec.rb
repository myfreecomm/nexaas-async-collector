RSpec.configure do |config|
  config.include RequestsWrapper, type: :controller
end
