TestingApp::Application.routes.draw do

  get "dashboard/index"

  devise_for :users

  resources :pictures
  resources :projects do
  	resources :tasks
  end
  root :to => 'dashboard#index'

end
