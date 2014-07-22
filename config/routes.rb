FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  resources :cards

end
