require 'redirector/rails/routes'
require 'redirector/rails/view_helpers'

module Redirector
  class Engine < Rails::Engine

      # TODO : I can't find a better way to include ViewHelpers by default.
      initializer "redirector.view_helpers" do
        config.after_initialize do
          ActionView::Base.send :include, Redirector::ViewHelpers
        end
      end

  end
end
