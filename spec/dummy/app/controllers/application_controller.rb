class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def application_dummy_action
  end
end
