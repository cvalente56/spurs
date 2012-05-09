
module Spurs
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end

end

require "spurs/modal"
require "spurs/flash"
require "spurs/nav"
require "spurs/section"
require "spurs/engine"

ActionView::Base.send :include, Spurs::Flash::Helper
ActionView::Base.send :include, Spurs::Nav::Helper
ActionView::Base.send :include, Spurs::Section::Helper
ActionView::Base.send :include, Spurs::Modal::Helper

ActionController::Base.send :include, Spurs::Flash::ControllerMods
ActionController::Base.send :include, Spurs::Modal::ControllerMods