module RequestsWrapper
  def xhr_request(http_method, action, parameters={})
    if Rails.version =~ /\A5/
      send(http_method, action, xhr: true, params: parameters)
    else
      xhr http_method, action, id: '12345'
    end
  end
end
