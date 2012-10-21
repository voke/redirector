module Redirector
  module Redirectable

    extend ActiveSupport::Concern

    included do
      class_attribute :redirect_attributes_options, :instance_writer => false
      self.redirect_attributes_options = {}
    end

    module ClassMethods

      # This is how the resource is loaded.
      #
      # You might want to overwrite this method when you are using custom finder method.
      # You can also pass :find_method as an option to :redirect_with (recommended).
      #
      #   def find_for_redirect(resource_id)
      #     find_by_permalink(resource_id)
      #   end
      #
      def find_for_redirect(resource_id)
        send(redirect_attributes_options[:find_method], resource_id)
      end

    end

    # Returns the generated url depending on redirect_options.
    # This is the method that is called on the resource in the controller.
    #
    def redirect_path
      generate_redirect_url
    end

    private

      # Returns the complete url depending on redirect_options.
      #
      def generate_redirect_url
        rp = RedirectPath.new
        rp.landing_page = call_redirect_option(:path)
        rp.base = call_redirect_option(:base)
        rp.epi = call_redirect_option(:epi)
        affiliate_url = rp.build_url
        try_add_redirect_tracking_url(affiliate_url)
      end

      def try_add_redirect_tracking_url(url)
        if Redirector::tracking_url
          Redirector::tracking_url.gsub(Redirector::url_pattern, url.to_s)
        else
          url
        end
      end

      # Make different call depending on option.
      #
      def call_redirect_option(key)
        case callback = redirect_attributes_options[key]
          when Symbol
            send(callback)
          when Proc
            callback.call(self)
          else
            callback
        end
      end

  end
end