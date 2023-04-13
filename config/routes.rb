Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do 
      post '/customers/:customer_id/subscriptions/:subscription_id', to: 'customers#subscribe'
      patch '/customers/:customer_id/subscriptions/:subscription_id', to: 'customers#unsubscribe'
      get '/customers/:customer_id/subscriptions', to: 'customers#index'
    end
  end
end
