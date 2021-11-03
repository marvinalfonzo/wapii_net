Rails.application.routes.draw do
  

  root 'users#principal'
  #root "users#index"
  #get 'users/comments'
  get 'users/trending'
  get 'users/influencer'
  get 'users/index'
  get 'posts/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
