class Product

  DEFAULT_ATTRIBUTES = {
    name: 'Foobar',
    url: 'http://store.com/product',
    affiliate_uri: 'http://network.com?url={url}&epi={epi}'
  }

  attr_accessor :id, :name, :url, :affiliate_uri

  extend Redirector::Models

  redirect_with :base => proc { |x| x.affiliate_uri }, :path => :url, :epi => :epi

  def initialize(attrs = {})
    self.id = rand(100)
    DEFAULT_ATTRIBUTES.merge(attrs).each do |key, value|
      public_send("#{key}=", value)
    end
  end

  def self.find(*args)
    new
  end

  def epi
    "product_#{name}".parameterize
  end

  def to_param
    name
  end

end