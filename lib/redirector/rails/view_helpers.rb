module Redirector
  module ViewHelpers
       
    # redirect_link('Go to product', product)
    def redirect_link_to(*args, &block)
      resource_index = block_given? ? 0 : 1
      args[resource_index] = send("redirect_#{args[resource_index].class.name.underscore}_path", args[resource_index])
      args[resource_index+1] = (args[resource_index+1] || {}).merge('data-external' => 'true', 'rel' => 'nofollow')
      link_to(*args,&block)
    end
              
  end
end