Rails.application.routes.draw do
  resources :users

  resources :tasks do
		get '/users' => 'tasks#add_user'
		post '/users' => 'tasks#add_user'
	end

	post 'login' => 'users#login_user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
