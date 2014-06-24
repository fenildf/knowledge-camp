Rails.application.routes.draw do
  root 'index#index'

  devise_for :users, :skip => :all
  as :user do
    get    "/account/sign_in"  => "sessions#new"
    post   "/account/sign_in"  => "sessions#create"
    delete "/account/sign_out" => "sessions#destroy"
  end

  get  '/upload' => 'upload#check'
  post '/upload' => 'upload#upload'

  namespace :manage do
    resources :nets, :shallow => true do
      member do
        get :graph
      end

      resources :points, :shallow => true
      resources :documents, :shallow => true do
        resources :versions, 
                  :shallow => true, 
                  :controller => :document_versions do
          collection do
            get ":version", :action => :version
            post ":version/restore", :action => :restore
          end
        end
      end
      resources :files, :shallow => true
      resources :plans, :shallow => true
    end

    resources :users, :shallow => true do
      resource :avatar, :shallow => true
    end
  end

  resources :plans, :shallow => true do
    resources :topics do
      resources :tutorials
    end
  end

end
