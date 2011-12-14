require "cgi"

module Redirector

  class RedirectPath
    
    attr_accessor :base, :landing_page, :epi
    
    def build_url
      return nil if landing_page.blank?
      redirect_url = base.present? ? base_with_landing_page : landing_page
      redirect_url.gsub(Redirector::epi_pattern,epi.to_s.downcase)
    end
  
    protected
  
      def base_with_landing_page
        self.base.gsub(Redirector::url_pattern,try_escape_url)
      end
  
      def try_escape_url
        if Redirector::ignore_encoding_hosts.any? { |x| self.base.include?(x) }
          landing_page
        else
          CGI.escape(landing_page)
        end
      end
  
  end

end
