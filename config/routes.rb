Rails.application.routes.draw do
  namespace "spurs" do
    resources :flashes, :only => [:create], :format => :js

  end
end
