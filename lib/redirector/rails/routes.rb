module ActionDispatch::Routing

  class Mapper

    # Helper method to generate the named_route(s) needed for the resource(s).
    #
    #   redirect_for :products
    #
    # => redirect_product /products/:product_id/redirect(.:format) { :controller=>"redirector/redirect", :action=>"redirect" }
    #
    def redirect_for(*resources, controller: 'redirector/redirect')
      resources.map(&:to_s).each do |resource|
        get "#{resource}/:#{resource.singularize}_id/redirect" => "#{controller}#redirect", :as => "redirect_#{resource.singularize}"
      end
    end

  end

end
