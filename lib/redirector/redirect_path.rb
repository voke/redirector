require "cgi"
require "addressable/uri"

module Redirector

  class RedirectPath

    attr_accessor :base, :landing_page, :epi

    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=", value)
      end
    end

    def build_url
      return nil if landing_page.blank?
      redirect_url = base.present? ? base_with_landing_page : landing_page
      if Redirector::epi_pattern
        redirect_url.gsub(Redirector::epi_pattern, epi.to_s)
      else
        redirect_url
      end
    end

    def base_with_landing_page
      base.gsub(Redirector::url_pattern, try_escape_url)
    end

    def host
      @host ||= extract_host_or_raise
    end

    def extract_host_or_raise
      Addressable::URI.parse(base).host || raise(ArgumentError, "Could not extract host from #{base}")
    end

    def parse_to_regexp(str)
      escaped = Regexp.escape(str).gsub('\*','.*?')
      Regexp.new "^#{escaped}$", Regexp::IGNORECASE
    end

    def ignore_encoding?
      Redirector::ignore_encoding_hosts.any? do |rule|
        regexp = parse_to_regexp(rule)
        host.match(regexp)
      end
    end

    def try_escape_url
      ignore_encoding? ? landing_page : CGI::escape(landing_page)
    end

  end

end
