module Spurs
  class FlashesController < ApplicationController
    def create
      respond_to do |format|
        format.js {
          render :file => 'spurs/flashes/add_message', :format => :js, :locals => {:_message => params[:message],:_flavor => params[:flavor]}
        }
      end
    end
  end
end
