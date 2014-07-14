Karma::Application.routes.draw do

	namespace :api, :defaults => {:format => :json} do
		resources :entries
	end

  resources :entries
	resources :tenants


	#match '/' => 'dashboards#show', :constraints => { :subdomain => /.+/ }, via: [:get]
	match '', to: 'dashboards#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }, via: [:get]

	#constraints(Subdomain) do  
  #  match '/' => 'dashboards#show', via: [:get] 
  #end 

  root  'custom_pages#home'

end
