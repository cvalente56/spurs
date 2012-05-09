module Spurs
  module Modal
    class Builder
      include ActionView::Helpers::TagHelper



      def build_modal(modal_id, content, options={ })

        if !options[:class] then
          options[:class] = ""
        end
        options[:class].concat(" modal fade #{modal_id}")

        c = String.new

        if options[:header]
          header_options = options.delete(:header)
          if header_options[:title]
            c.concat(build_modal_title(header_options[:title], header_options[:icon]))
          end
        end


        #body
        c.concat(content_tag(:div, content, :class => "modal-body"))

        if options[:actions]
          actions_options = options.delete(:actions)
          c.concat(build_modal_footer(actions_options).html_safe)
        end


        content_tag(:div, c.html_safe, :class => options[:class], 'data-modal-id' => "#{modal_id}")

      end



      private
      def build_modal_title(title, icon)
        c = String.new
        if icon != nil
          c.concat(content_tag(:img, '', :src => icon, :style => "float: left; margin-right: 10px; height: 36px").html_safe)
        end
        c.concat(content_tag(:h1, title))
        content_tag(:div, c.html_safe, :class => "modal-header")
      end



      def build_modal_footer(actions)
        c = String.new

        left_content   = "&nbsp;"
        right_content  = "&nbsp;"
        center_content = "&nbsp;"

        actions.each do |action|
          class_str = "btn"
          if action[:position]
            if action[:position] == :left
              left_content.concat(build_action_button(action))
            else
              if action[:position] == :right
                right_content.concat(build_action_button(action))
              else
                if action[:position] == :center
                  center_content.concat(build_action_button(action))
                end
              end
            end
          end
        end

        left_area   = content_tag(:div, left_content.html_safe, :style => "width: 32%; text-align: left; float: left")
        right_area  = content_tag(:div, right_content.html_safe, :style => "width: 32%; text-align: right; float: left")
        middle_area = content_tag(:div, center_content.html_safe, :style => "width: 33%; text-align: center; float:left")

        c.concat(left_area).concat(middle_area).concat(right_area)

        content_tag(:div, c.html_safe, :class => "modal-footer")
      end



      def build_action_button(action)
        class_str = "btn #{action[:class] ? action[:class] : ""} btn-large"

        attrs = {
            :onclick => ""
        }

        if action[:action]
          if action[:action].kind_of?(Symbol)
            case action[:action]
              when :close_modal then
                attrs[:onclick] = "m=$(this).closest('.modal');m.modal('hide')"
              when :submit_form_and_close_modal then
                attrs[:onclick] = "m=$(this).closest('.modal');m.find('.modal-body form').submit();m.modal('hide')"
              else
                raise "Unknown button action \"#{action[:action].to_json}\""
            end
          end
        end

        if attrs[:onclick] == ""
          attrs.delete(:onclick)
        end
        attrs[:class] = class_str


        content_tag(:a, action[:name].to_s.titlecase.html_safe, attrs)

      end
    end
  end
end
