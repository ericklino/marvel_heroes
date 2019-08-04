Rails.application.routes.draw do

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'heroes' => 'heroes#index', as: :heroes
  get 'heroes/:id' => 'heroes#show', as: :heroe
  get 'heroes/:id/comics' => 'heroes#comics', as: :heroe_comics

  
end
