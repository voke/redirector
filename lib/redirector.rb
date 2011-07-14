module Redirector
  
  require 'redirector/engine'
  require 'redirector/redirect_path'
  require 'redirector/redirectable'
  require 'redirector/models'
  
  # For mongoid ORM
  if defined?(::Mongoid::Document)
    Mongoid::Document::ClassMethods.class_eval do
      include Redirector::Models
    end
  end
  
  # For ActiveRecord ORM
  ActiveRecord::Base.extend(Redirector::Models) if defined?(::ActiveRecord::Base)
  
end