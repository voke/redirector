module ActionDispatch::Routing
  
  class Mapper
        
    def redirect_for(*resources)
      resources.map!(&:to_s)
      resources.each do |resource|
        match "#{resource}/:#{resource.singularize}_id/redirect" => "redirector/redirect#redirect", :as => "redirect_#{resource.singularize}"
      end
    end
      
  end
  
end