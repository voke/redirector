class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Redirector::Engine::helpers

end
