Rails.application.routes.draw do
  root to: 'pages#home'
  resources :contacts, only: :create

  get 'about', to: 'pages#about'
  get  'contact-us', to: 'contacts#new', as: 'new_contact'
end
