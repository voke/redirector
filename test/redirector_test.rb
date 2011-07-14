require 'test_helper'

class RedirectorTest < ActiveSupport::TestCase
    
  test "truth" do
    assert_kind_of Module, Redirector
  end
  
  test "generate redirect_path for model" do
    p = Fabricate.build(:product)
    assert_equal 'http://network.com?url=http%3A%2F%2Fstore.com%2Fproduct&epi=product_foobar', p.redirect_path
  end
  
  test 'skip url escape if affiliate_url matches ignore filter' do
    p = Fabricate.build :product, affiliate_uri: 'http://affiliator.com?url={url}&epi={epi}'
    assert_equal 'http://www.affiliator.com?url=http://store.com/product&epi=product_foobar', p.redirect_path
  end
  
  test 'should use (unescaped) path_url if build_url is blank' do
    p = Fabricate.build :product, affiliate_uri: nil
    assert_equal "http://store.com/product", p.redirect_path
  end
  
  test 'should return nil when no path exists' do
    p = Fabricate.build :product, url: nil
    assert_nil p.redirect_path
  end
  
end

class Redirector::RedirectControllerTest < ActionController::TestCase
  
  setup do
    @product = Product.create(name: 'Bar', url: 'http://store.com/product', affiliate_uri: 'http://network.com?url={url}&epi={epi}')
  end
  
  test 'redirect action' do
    get(:redirect, { product_id: @product.id })
    assert_response :success
  end
  
end