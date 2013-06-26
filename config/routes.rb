RedmineApp::Application.routes.draw do
  resources :bookmarks, :except => [:index, :show]
end
