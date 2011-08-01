require "cgi"

module Redirector

  class RedirectPath
    
    DEFAULT_EPI_PATTERN = /\{epi\}/
    DEFAULT_URL_PATTERN = /\{url\}/
    
    # Affiliate networks that doesn't support encoded urls for landing-pages
    IGNORE_ENCODING = ["affiliator.com","adtraction.com","partner-ads.com","smartresponse-media.com"]
  
    attr_accessor :base, :landing_page, :epi
    
    def build_url
      return nil if landing_page.blank?
      redirect_url = base.present? ? base_with_landing_page : landing_page
      redirect_url.gsub(DEFAULT_EPI_PATTERN,epi.to_s.downcase)
    end
  
    protected
  
      def base_with_landing_page
        self.base.gsub(DEFAULT_URL_PATTERN,try_escape_url)
      end
  
      def try_escape_url
        if IGNORE_ENCODING.any? { |x| self.base.include?(x) }
          landing_page
        else
          CGI.escape(landing_page)
        end
      end
  
  end

end
