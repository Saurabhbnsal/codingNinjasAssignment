Rails.application.routes.draw do
  root 'login#index'
  post "/", to: 'login#post'
  get "/login", to: 'login#index'
  post "/login", to: 'login#post'
  get "/doubts", to:"doubts#index"
  post "/doubts", to:"doubts#create"
  get "/ask-doubt", to: "ask#index"
  post "/ask-doubt", to: "ask#create"

  get "/ta-doubts", to: "ta_doubts#index"
  post "/ta-doubts", to: "ta_doubts#accept"
 
  get "/solve-doubt/:id", to: "solve_doubt#index"
  post "/solve-doubt/:id", to: "solve_doubt#update"
  # put "/solve-doubt/:id", to: "solve_doubt#escalate"
  resources :solve
  get "/dashboard", to: "dashboard#index"
  # get "/dashboard", to: "dashboard#getUsers"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
