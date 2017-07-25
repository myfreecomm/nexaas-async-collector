module RequestsWrapper
  def xhr_request(http_method, action, parameters = {})
    if Rails.version =~ /\A5/
      send(http_method, action, xhr: true, params: parameters)
    else
      xhr http_method, action, parameters
    end
  end

  def send_request(http_method, action, parameters = {})
    if Rails.version =~ /\A5/
      send(http_method, action, params: parameters)
    else
      send(http_method, action, parameters)
    end
  end
end

RSpec.configure do |config|
  config.include RequestsWrapper, type: :controller
end
