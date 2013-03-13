class Redirector::RedirectController < ApplicationController

  before_filter :find_resource, :run_redirect_hook, only: :redirect

  # GET /redirect
  def redirect
    @redirect_path = @resource.redirect_path
    render :layout => false
  end

  protected

    def find_resource
      @resource = resource_class.find_for_redirect resource_id
    end

    def run_redirect_hook
      before_redirect(@resource) if respond_to?(:before_redirect)
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