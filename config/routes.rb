Rails.application.routes.draw do
	resources :users

	root 'static_pages#home'

	get '/mailList', to: 'mail_lists#index'
	get '/mailListAdd', to: 'mail_lists#new'
	post '/mailListAdd', to: 'mail_lists#create'
	get '/mailListEdit/:id', to: 'mail_lists#edit', as: "mailListEdit"
	patch '/mailListEdit/:id', to: 'mail_lists#update'
end
