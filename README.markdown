Redirector
--------

Redirector allows you to easily generate a redirect action
for a specific resource.

``` ruby
class Product
  belongs_to :store
  delegate :parameterize, to: :name
  redirect_with base: -> x { x.store.affiliate_uri }, path: :url, epi: :parameterize
end
```

Define redirect routes:

``` ruby
Foobar::Application.routes.draw do
  redirect_for :products
end
```

Generate the redirect link:

``` erb
<<<<<<< HEAD
<%= link_for 'Go to product', redirect_product_path(@product) %>
```

Or use the view helper:

``` erb
<%= redirect_link_to 'Go to product', @product %>
```