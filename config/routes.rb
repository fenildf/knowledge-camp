def routes_draw(routes_name)
  instance_eval(File.read(Rails.root.join('config', "routes_#{routes_name}.rb")))
end

routes_draw :mockup

Rails.application.routes.draw do
  root 'index#index'

  get '/search/:query' => 'search#search', as: :search

  devise_for :users, :skip => :all,
    only: :omniauth_callbacks,
    controllers: {
      omniauth_callbacks: 'authentications'
    }

  # 文件上传
  mount FilePartUpload::Engine => "/e/file_part_upload", :as => :e_file_part_upload
  # 课程功能
  KcCourses::Routing.mount '/e/kc_courses', as: :e_courses
  # 短信验证
  mount PhoneNumberCheckMod::Engine => '/e/phone_number_check_mod', :as => :e_phone_number_check_mod

  # --------------------
  # kc mobile 2016
  get "/user_dashboard"              => "user_dashboard#index",        as: :user_dashboard
  get "/user_dashboard/my_courses"   => "user_dashboard#my_courses",   as: :user_dashboard_my_courses
  get "/user_dashboard/my_notes"     => "user_dashboard#my_notes",     as: :user_dashboard_my_notes
  get "/user_dashboard/my_questions" => "user_dashboard#my_questions", as: :user_dashboard_my_questions
  resources :subjects
  resources :courses do
    get "/wares/:ware_id" => "courses#ware", as: :ware
  end

  resources :questions do
    get :ware, on: :collection
  end

  resources :notes do
    get :ware, on: :collection
  end

  devise_scope :user do
    get    "/sign_in"      => "sessions#new"
    post   "/api/sign_in"  => "sessions#create"
    delete "/api/sign_out" => "sessions#destroy"

    get    "/sign_up"      => "registrations#new"
    post   "/api/sign_up"  => "registrations#create"
    get    "/api/check_phone_number" => "registrations#check_phone_number"

    get "/users/edit" => "registrations#edit"
    put "/users"      => "registrations#update"
  end

  resources :business_categories do
    get :my, on: :collection
  end

  resources :wares do
    post :read, on: :member
  end
  resources :simple_video_wares
  resources :simple_document_wares
  resources :teller_wares do
    get :hmdm, on: :collection
  end

  resources :articles, shallow: true do
    get :landing, on: :collection
    resources :comments, shallow: true
  end

  scope :path => "/manager", module: 'manager', as: :manager do
    get "dashboard" => "dashboard#index"

    # 文章维护
    resources :articles
    # 督导员维护
    resources :supervisors
    # 柜员维护
    resources :tellers
    # 督导员的柜员维护
    resources :supervisor_tellers

    resources :courses, shallow: true do
      get :organize, on: :member
      resources :chapters, shallow: true do
        put :move_up,   on: :member
        put :move_down, on: :member
        resources :wares do
          put :move_up,   on: :member
          put :move_down, on: :member
        end
      end
    end

    resources :course_subjects

    resources :published_courses do
      post   :publish, on: :collection
      delete :recall,  on: :collection
    end

    # 视频课件管理
    resources :simple_video_wares do
      get  :edit_business_categories,   on: :member
      put :update_business_categories, on: :member
    end

    # 文档课件管理
    resources :simple_document_wares  do
      get  :edit_business_categories,   on: :member
      put :update_business_categories, on: :member
    end

    resources :business_categories
    resources :enterprise_posts do
      get  :edit_business_categories,   on: :member
      put :update_business_categories, on: :member
    end
    resources :enterprise_levels

    scope :path => '/finance', module: 'finance', as: :finance do
      resources :teller_wares do
        get :screens, on: :collection
        get :trades, on: :collection

        get :trade, on: :collection

        get :hmdm, on: :collection
        get :edit_screen_sample, on: :collection
        put :update_screen_sample, on: :collection

        get :design, on: :member
        put :design_update, on: :member

        get  :edit_business_categories,   on: :member
        put :update_business_categories, on: :member
      end
      get '/teller_wares/:number/preview' => "teller_wares#preview", as: :preview

      resources :teller_ware_media_clips do
        get :search, on: :collection
        get :get_infos, on: :collection
      end
    end

  end
end
