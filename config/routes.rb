TasksVateudNet::Application.routes.draw do

  get "help" => 'users#help'

  devise_for :users
  resources :users, :except => [:new, :create]
  get 'tasks/my' => 'tasks#my'
  get 'tasks/archived' => 'tasks#archived'
  resources :tasks
  resources :attachments, :except => [:index, :show]
  resources :comments, :except => [:show]


  put 'tasks/accept/:id' => 'tasks#accept'
  put 'tasks/cancel/:id' => 'tasks#cancel'
  put 'tasks/progress/:id' => 'tasks#progress'
  put 'tasks/halt/:id' => 'tasks#halt'
  put 'tasks/complete/:id' => 'tasks#complete'
  put 'users/enable/:id' => 'users#enable'
  put 'users/disable/:id' => 'users#disable'
  put 'users/staff/:id' => 'users#staff'
  put 'users/destaff/:id' => 'users#destaff'
  get 'forbidden' => 'tasks#forbidden'
  get 'rss' => 'tasks#rss'
  get 'rss_completed' => 'tasks#rss_completed'
  get 'rss_comments' => 'tasks#rss_comments'

  root :to => 'tasks#index'

end
