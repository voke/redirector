module Redirector
  module Redirectable

    extend ActiveSupport::Concern
        
    included do
      class_attribute :redirect_attributes_options, :instance_writer => false
      self.redirect_attributes_options = {}
    end
    
    module ClassMethods
      
      # Method that is called in controller.
      # Easy way to overwrite for custom finder
      def find_for_redirect(resource_id)
        send(redirect_attributes_options[:find_method], resource_id)
      end
      
    end
    
    # The method that is called in the controller        
    def redirect_path
      generate_redirect_url
    end
                  
    private
      
      # Generate URL with base, path and epi            
      def generate_redirect_url        
        rp = RedirectPath.new # Create helper object
        rp.landing_page = call_redirect_option(:path)
        rp.base = call_redirect_option(:base)
        rp.epi = call_redirect_option(:epi)
        rp.build_url # Generates the complete url
      end
        
      # Make different call depending on option
      # Nil is returned if key is empty 
      def call_redirect_option(key)
        case callback = redirect_attributes_options[key]
          when Symbol
            send(callback)
          when Proc
            callback.call(self)
        end
      end
          
  end
end