Rails.application.routes.draw do
  scope '(:locale)' do
  resources :posts
  get 'about', to: 'static_pages#about'
  root to: 'static_pages#home'
  get 'static_pages/home'

  get 'static_pages/about'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
