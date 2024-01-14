Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations', confirmations: 'confirmations' }

  root 'client/posts#index'
  
  scope "switch/" do
    get 'become_freelancer', to: 'switch#become_freelancer', as: 'become_freelancer'
    get 'switch as client', to: 'switch#switch_as_client', as: 'client'
    get 'switch as freelancer', to: 'switch#switch_as_freelancer', as: 'freelancer'
  end

  namespace :client do
    resources :posts
  end

  resource :profile, module: 'freelancer', controller: :profile do
    collection do
      get 'experiences'
      get 'education'
      get 'languages'
      get 'certifications'
      get 'avatar'
    end
  end
  resolve('Profile') { [:profile] }
end