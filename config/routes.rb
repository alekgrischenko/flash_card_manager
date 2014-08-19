FlashCardMNGer::Application.routes.draw do
 
  root 'static_pages#index'
  
  shallow do
    resources :decks do
      resources :cards 
    end
  end
  
  resources :user_sessions
  resources :users do 
    member do
      put 'set_current_deck'
    end
  end

  put 'check_translation', to: 'review#check_translation'
  get 'login',             to: 'user_sessions#new'     
  post 'logout',           to: 'user_sessions#destroy' 
end
