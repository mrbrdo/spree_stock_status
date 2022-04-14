Spree::Core::Engine.routes.draw do
  namespace :admin, path: Spree.admin_path do
    resources :stock_statuses
  end
end
