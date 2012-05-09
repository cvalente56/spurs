require "spurs/nav/builder"
require "spurs/nav/helper"

module Spurs
  module Nav
    @@nav_default_options = {
        :type => :tabs,
        :builder => Spurs::Nav::Builder
    }

    def self.nav_default_options
      @@nav_default_options
    end

    @@submenu_default_options= { }

    def self.submenu_default_options
      @@submenu_default_options
    end

  end
end

