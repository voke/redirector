# encoding : utf-8
require 'test_helper'

class RedirectorTest < ActiveSupport::TestCase

  test "truth" do
    assert_kind_of Module, Redirector
  end

  test "ensure that Mongoid::Document responds to redirect_with" do
    assert Product.respond_to? :redirect_with
  end

  test "generate redirect_path for model" do
    p = Fabricate.build :product
    assert_equal 'http://network.com?url=http%3A%2F%2Fstore.com%2Fproduct&epi=product_foobar', p.redirect_path
  end

  test 'skip url escape if affiliate_url matches ignore filter' do
    p = Fabricate.build :product, affiliate_uri: 'http://affiliator.com?url={url}&epi={epi}'
    assert_equal 'http://affiliator.com?url=http://store.com/product&epi=product_foobar', p.redirect_path
  end

  test 'should use (unescaped) path_url if build_url is blank' do
    p = Fabricate.build :product, affiliate_uri: nil
    assert_equal "http://store.com/product", p.redirect_path
  end

  test 'should return nil when no path exists' do
    p = Fabricate.build :product, url: nil
    assert_nil p.redirect_path
  end

  test "should support String as option" do
    p = Fabricate.build :product
    p.class_eval { redirect_with :base => proc { |x| x.affiliate_uri }, :path => :url, :epi => '{invk_epi}' }
    assert_equal 'http://network.com?url=http%3A%2F%2Fstore.com%2Fproduct&epi={invk_epi}', p.redirect_path
  end

  test "custom finder method as option" do
    pending 'the expects() method doesnt work as expected. Read more: https://github.com/floehopper/mocha/issues/26'
    klass = Class.new Product
    klass.class_eval do
      redirect_with :base => 'hello', :path => 'world', :epi => 'foo', :find_method => :my_custom_find
      def self.my_custom_find(resource_id); end
    end
    klass.expects(:attribute_names).twice
    klass.find_for_redirect(123)
  end

end

class RedirectPathTest < ActiveSupport::TestCase

  test "."

end

class RedirectRoutingTest < ActionController::TestCase

  test 'redirect_for' do
    assert_recognizes({ controller: 'redirector/redirect', product_id: "123", action: 'redirect' }, { path: 'products/123/redirect', method: :get })
    assert_named_route "/products/123/redirect", :redirect_product_path, 123
  end

  protected

    def assert_named_route(result, *args)
      assert_equal result, @routes.url_helpers.send(*args)
    end

end

class Redirector::RedirectControllerTest < ActionController::TestCase

  test 'redirect action and view' do
    product = Fabricate(:product)
    get :redirect, product_id: product.id
    assert_response :success
    assert_template "redirect"
    assert_select "script", 'document.location.href = "http://network.com?url=http%3A%2F%2Fstore.com%2Fproduct&epi=product_foobar";'
  end

  test 'replace epi with cookie value if it exists' do
    product = Fabricate :product, affiliate_uri: 'http://network.com?url={url}&epi={invk_epi}'
    @request.cookies[:invk_uid] = "11223344556677889900"
    get :redirect, product_id: product.id
    assert_equal 'http://network.com?url=http%3A%2F%2Fstore.com%2Fproduct&epi=11223344556677889900', assigns(:redirect_path)
  end

end

class Redirector::ViewHelpersTest < ActionView::TestCase

  def setup
    @product = Fabricate(:product, name: 'foobar')
  end

  test 'Included in ActionView::Base' do
    assert ActionView::Base.instance_methods.include? :redirect_link_to
  end

  test 'redirect_link_to with resource' do
    expected = %q{<a href="/products/foobar/redirect" data-external="true" rel="nofollow">Go to product</a>}
    assert_equal(expected, redirect_link_to('Go to product', @product))
  end

  test "redirect_link_to with block" do
    expected = %q{<a href="/products/foobar/redirect" data-external="true" rel="nofollow">My block data</a>}
    assert_equal(expected, redirect_link_to(@product) { 'My block data' })
  end

  test 'redirect_link_to with resource and additional html_options' do
    expected = %q{<a href="/products/foobar/redirect" class="qwerty" data-external="true" rel="nofollow">Go to product</a>}
    assert_equal(expected, redirect_link_to('Go to product', @product, class: 'qwerty'))
  end

  test 'redirect_link_to with block and additional html_options' do
    expected = %q{<a href="/products/foobar/redirect" class="qwerty" data-external="true" rel="nofollow">My block data</a>}
    assert_equal(expected, redirect_link_to(@product, class: 'qwerty') { 'My block data'} )
  end

  test 'redirect_link_to with overwritten html_options' do
    expected = %q{<a href="/products/foobar/redirect" class="qwerty" data-external="false" rel="foobar">My block data</a>}
    assert_equal(expected, redirect_link_to(@product, class: 'qwerty', 'data-external' => false, 'rel' => 'foobar' ) { 'My block data'} )
  end

end