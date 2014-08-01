FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  resources :cards
  resources :users
  put 'check_translation',  to: 'review#check_translation'
  
end
