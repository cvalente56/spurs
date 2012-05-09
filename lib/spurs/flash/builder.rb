module Spurs
  module Flash
    class Builder
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::AssetTagHelper

      def build_alert(message,my_options)
        if message == nil
          raise "No message! #{my_options.to_json}"
        end
        my_content = String.new

        if my_options[:close_button]
          my_content.concat(content_tag(:a, "&#215;".html_safe, :class => :close, 'data-dismiss' => :alert))
        end

        header_content = my_options[:title]
        if my_options[:title_icon]
          header_content = content_tag(:img, nil, :src => "/assets/#{my_options[:title_icon]}", :style => "margin-bottom: 2px; margin-right: 5px; float: left").concat(header_content)
        end

        my_content.concat(alert_header_tag(header_content))

        my_content.concat(content_tag(:p, message.to_s.html_safe))


        alert_tag(my_content.html_safe, my_options)
      end

      private
      def alert_header_tag(content, args={ })
        my_args = { :class => "alert-heading" }.merge args
        content_tag(:h4, content, my_args)
      end

      def alert_tag(content, args={ })
        class_string = "alert"


        if args[:flavor]
          flavor_str = args[:flavor]
          if flavor_str == :notice
            flavor_str = :success
          end
          class_string.concat(" alert-#{flavor_str}")
        end
        if args[:block] != nil && args[:block] == true
          class_string.concat(" alert-block")
        end
        content_tag(:div, content, :class => class_string)
      end
    end
  end
end