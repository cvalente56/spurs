module Spurs
  module Flash
    # Flavors of flash message that we know how to deal with
    ##
    @@flavors       = [:error, :notice, :info, :warning]
    @@flavor_titles = {
        :error   => I18n.t(:error, :default => "error").titlecase,
        :notice  => I18n.t(:notice, :default => "notice").titlecase,
        :info    => I18n.t(:info, :default => "info").titlecase,
        :warning => I18n.t(:warning, :default => "warning").titlecase
    }
    @@flavor_icons  = {
        :error   => "spurs/icons/16x16/delete.png",
        :notice  => "spurs/icons/16x16/accept.png",
        :info    => "spurs/icons/16x16/info.png",
        :warning => "spurs/icons/16x16/warning.png"
    }

    def self.flavor_icons
      @@flavor_icons
    end

    def self.flavor_titles
      @@flavor_titles
    end

    @@default_args = {
        :dynamic => {
            :block        => true,
            :flavor       => :info,
            :lifetime     => 5000,
            :close_button => true
        },
        :default => {
            :block        => true,
            :flavor       => :info,
            :lifetime     => -1,
            :close_button => true
        }
    }

    def self.default_args
      @@default_args
    end

    def self.flavors
      @@flavors
    end
  end
end

require "spurs/flash/builder"
require "spurs/flash/helper"
require "spurs/flash/controller_mods"