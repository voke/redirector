class ApplicationController < ActionController::Base
  protect_from_forgery

  helper Redirector::Engine::helpers

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale]
  end

  def before_redirect(resource, path)
    # render text: @redirect_path
    # return false
  end

end


