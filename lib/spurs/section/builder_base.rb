class Spurs::Section::BuilderBase
  include ActionView::Helpers::TagHelper

  @options_from_helper
  def initialize(args={})
    @options_from_helper = args.clone
  end

end