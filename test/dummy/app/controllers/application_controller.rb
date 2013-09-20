class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Redirector::Engine::helpers

  def before_redirect(resource)
  end

end
