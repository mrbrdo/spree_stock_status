Spree::Core::Engine.routes.draw do
  namespace :admin, path: Spree.admin_path do
    resources :stock_statuses
    resources :stock_arrivals
  end
end
