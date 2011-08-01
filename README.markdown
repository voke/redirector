Redirector
--------

Redirector allows you to easily generate a redirect action
for a specific resource.

``` ruby
class Product
  belongs_to :store
  delegate :parameterize, to: :name
  redirect_with base: -> { |x| x.store.affiliate_uri }, path: :url, epi: :parameterize
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
<%= link_for 'Go to product', product_redirect_path(@product) %>
```