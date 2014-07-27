FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  resources :cards
  put 'check_translation',  to: 'review#check_translation'
end
