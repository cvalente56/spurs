module Spurs
  module Badge
    module Helper
      def spurs_badge(content, options={})
        class_str ="badge"
        if options[:type]
          class_str.concat(" badge-#{options[:type]}")
        end
        content_tag(:span,content.html_safe,:class => class_str)
      end
    end
  end
end