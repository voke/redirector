class Redirector::RedirectController < ApplicationController
  
  # GET /redirect  
  def redirect
    @resource = resource_class.find_for_redirect resource_id
    @redirect_path = try_replace_epi_value_with_cookie @resource.redirect_path
    render :layout => false
  end
  
  protected
    
    def try_replace_epi_value_with_cookie(path)
      cookies[:invk_uid].present? ? path.gsub("{invk_epi}",cookies[:invk_uid]) : path
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