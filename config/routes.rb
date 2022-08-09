Rails.application.routes.draw do
  resources :categories
  get "events/filter/:filter"=> "events#index",as: :filter_event
  resources :users
  resource :session, only: [:new,:create,:destroy]
  root "events#index"
  # get "events" => "events#index"
  # get "events/new" => "events#new"
  # get "events/:id" => "events#show",as:"event"
  # get "events/:id/edit" => "events#edit",as:"edit_event"
  # patch "events/:id" => "events#update"
  # post "events" => "events#create"
  # delete "events/:id" => "events#destroy"
  resources :events do 
    resources :likes
    resources :registrations,shallow: true
  end
  

 
 
end
