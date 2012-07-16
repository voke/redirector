require "cgi"

module Redirector

  class RedirectPath

    attr_accessor :base, :landing_page, :epi

    def build_url
      return nil if landing_page.blank?
      redirect_url = base.present? ? base_with_landing_page : landing_page
      redirect_url.gsub(Redirector::epi_pattern, epi.to_s)
    end

    protected

      def base_with_landing_page
        base.gsub(Redirector::url_pattern, try_escape_url)
      end

      def host
        @host ||= URI.parse(base).host
      end

      def ignore_encoding?
        Redirector::ignore_encoding_hosts.include?(host)
      end

      def try_escape_url
        ignore_encoding? ? landing_page : CGI.escape(landing_page)
      end

  end

end
