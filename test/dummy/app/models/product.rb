class Product
  
  include Mongoid::Document
  
  field :name
  field :url
  field :affiliate_uri
    
  redirect_with :base => proc { |x| x.affiliate_uri }, :path => :url, :epi => :epi
      
  def epi
    "product_#{name}"
  end

  def to_param
    name
  end

end