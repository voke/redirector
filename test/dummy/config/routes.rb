Dummy::Application.routes.draw do

  redirect_for :products
  
  root to: 'home#index'

end
