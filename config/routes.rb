FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  resources :cards
  resources :users
  resources :user_sessions
  
  put 'check_translation',  to: 'review#check_translation'
  get 'login',              to: 'user_sessions#new'     
  post 'logout',            to: 'user_sessions#destroy' 
end
