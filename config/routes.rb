Rails.application.routes.draw do
  locales = /en|es/

  scope "(:locale)", :locale => locales do
    namespace "spurs" do
      resources :flashes, :only => [:create], :format => :js

    end
  end
end
