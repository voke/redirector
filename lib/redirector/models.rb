module Redirector
  module Models

    # Defines the methods to call when generating the redirect path
    # redirect_with :base => proc { |x| x.store.affiliate_uri }, :path => :url, :epi => proc { |x| "foo_#{x.id}"}
    #
    def redirect_with(*args)
      include Redirector::Redirectable
      options = args.extract_options!
      options.assert_valid_keys(:base, :path, :epi, :find_method)
      self.redirect_attributes_options = options.reverse_merge(:find_method => :find)
    end

  end
end