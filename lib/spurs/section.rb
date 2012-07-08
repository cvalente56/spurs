require "spurs/section/helper"
require "spurs/section/collapsible_section_builder"
require "spurs/section/section_builder"
module Spurs
  module Section
    @@collapsible_section_default_options = {
        :icon_collapsed => "chevron-right",
        :icon_expanded => "chevron-down",
        :builder => Spurs::Section::CollapsibleSectionBuilder
    }
    def self.collapsible_section_default_options
      @@collapsible_section_default_options
    end

    @@section_default_options = {
        :builder => Spurs::Section::SectionBuilder
    }
    def self.section_default_options
      @@section_default_options
    end
  end
end

