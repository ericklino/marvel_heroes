Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'heroes' => 'heroes#index', as: :heroes_index
end
