module Spurs
  module Section
    module Helper
      include ActionView::Helpers::TagHelper

      def spurs_collapsible_section(title,options={},&block)
        opts = Spurs::Section::collapsible_section_default_options.merge(options)
        if !opts[:builder]
          raise "Null builder"
        end

        options_to_pass_to_builder = {}
        builder = opts[:builder].new(options_to_pass_to_builder)
        section_content = capture(nil,&block)
        builder.build_collapsible_section(title,section_content)
      end

      def spurs_vcenter(options={}, &block)
        opts = options.clone
        if !opts[:class]
          opts[:class] = ""
        end
        opts[:class].concat(" vcenter_outer")

        # extract inner options
        inner_opts = opts[:inner_html] ? opts.delete(:inner_html) : {}
        if !inner_opts[:class]
          inner_opts[:class] = ""
        end
        inner_opts[:class].concat(" inner")

        section_content = capture(nil,&block)
        content_tag(:div,content_tag(:div, content_tag(:div,section_content,inner_opts),:class => "middle"),opts)
      end
    end
  end
end