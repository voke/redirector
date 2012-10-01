module Redirector

  require 'redirector/engine'
  require 'redirector/redirect_path'
  require 'redirector/redirectable'
  require 'redirector/models'

  if defined?(::Mongoid::Document)
    Mongoid::Document::ClassMethods.class_eval do
      include Redirector::Models
    end
  end

  ActiveRecord::Base.extend(Redirector::Models) if defined?(::ActiveRecord::Base)

  mattr_accessor :epi_pattern
  @@epi_pattern = /\{epi\}/

  mattr_accessor :url_pattern
  @@url_pattern = /\{url\}/

  mattr_accessor :tracking_url
  @@tracking_url = nil

  # Affiliate networks that doesn't support encoded urls for landing-pages
  # NOTE: can use asterix (*) to support subdomains (for example)
  mattr_accessor :ignore_encoding_hosts
  @@ignore_encoding_hosts = [
    'click.affiliator.com',
    'track.adtraction.com',
    '*.partner-ads.com',
    'smartresponse-media.com',
    'ads.guava-affiliate.com'
  ]

  mattr_accessor :redirect_link_options
  @@redirect_link_options = { 'data-external' => 'true', 'rel' => 'nofollow' }

  def self.setup
    yield self
  end

end


