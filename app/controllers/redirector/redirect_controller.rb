class Redirector::RedirectController < ApplicationController

  before_filter :find_resource, :set_redirect_path, :run_redirect_hook, only: :redirect

  # GET /redirect
  def redirect
    render :layout => false
  end

  protected

    def find_resource
      @resource = resource_class.find_for_redirect resource_id
    end

    def set_redirect_path
      @redirect_path = @resource.redirect_path
    end

    def run_redirect_hook
      before_redirect(@resource, @redirect_path) if respond_to?(:before_redirect)
    end

    def extract_resource
      params.keys.map { |x| x.to_s.match(/(.+)_id/) }.compact.first
    end

    def resource_id
      params[extract_resource[0]]
    end

    def resource_name
      extract_resource[1]
    end

    def resource_class
      resource_name.classify.constantize
    end

end