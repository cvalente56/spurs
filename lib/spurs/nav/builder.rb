module Spurs
  module Nav
    class Builder
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::ControllerHelper
      include ActionView::Helpers::UrlHelper

      @@default_tab_options = {
          :icon_only => false
      }

      @@default_dropdown_options = {
          :href      => "#",
          :method    => :get,
          :icon_only => false
      }

      @args_from_helper

      def initialize(controller, opts={ })
        @args_from_helper = opts.clone
        assign_controller(controller)
      end

      # Create a tab
      # *options
      # :label => overrides display name
      # :href => link for tab
      # :onclick => onclick for tab
      # *active
      # :active => true  will force the tab to be active
      # :active => [{:controller => 'pages', :action => 'index'},{:controller => 'pages', :action => 'new'}]
      def tab(name, options={ })
        tab_tag(name, nil, nil, options)
      end

      def list_header(name)
        content_tag(:li, name, :class => 'nav-header')
      end

      # Create a dropdown
      # *options
      # :label => overrides display name
      def dropdown(name, options={ })
        opts    = options.merge({ :dropdown => true })
        actions = options[:actions] ? options[:actions] : []
        tab_tag(name, content_tag_string(:b, '', :class => "caret").html_safe, build_drop_down_menu(actions).html_safe, opts)

      end

      private

      def tab_tag(name, content_inside_a, content_inside_li=nil, options={ })

        if options.is_a?(Array) then
          raise "opts should be a hash! #{opts.to_json}"
        end

        opts         = @@default_tab_options.merge(@args_from_helper.merge(options))

        ## Figure out the display name. Use the :label property if one is provided, otherwise use the symbol
        display_name = opts[:label] ?
            opts[:label] :
            name.to_s.titlecase

        #options for a tag
        a_opts       = if options[:dropdown] then
                         { :class => 'dropdown-toggle', 'data-toggle' => :dropdown }
                       else
                         options[:dynamic] ? { 'data-tabs' => :tabs } : { }
                       end


        #options for li tag
        li_opts      = options[:dropdown] ?
            { :class => 'dropdown', 'data-dropdown' => :dropdown } :
            { }

        if li_opts[:class] == nil then
          li_opts[:class] = ""
        end
        if a_opts[:class] == nil then
          a_opts[:class] = ""
        end

        ## The icon for this tab
        if opts[:icon]
          if opts[:icon_only]
            old_dn       = display_name.clone
            display_name = content_tag_string(:i, nil, :class => "icon-#{opts[:icon].to_s}")
            #add the tooltip
            li_opts[:class].concat(" has_tooltip ")
            li_opts['data-original-title'] = old_dn
          else
            display_name = content_tag_string(:i, nil, :class => "icon-#{opts[:icon].to_s}").concat(display_name)
          end
        end


        if opts[:dynamic] && (opts[:dropdown] == nil || opts[:dropdown] == false)
          a_opts['data-toggle'] = :tab
        end


        # Process :href and :onclick
        if opts[:href] then
          a_opts[:href] = opts[:href]
          if opts[:method] then
            a_opts[:method] = opts[:method]
          end
        end
        if opts[:onclick]
          a_opts[:onclick] = opts[:onclick]
          if !opts[:href]
            a_opts[:href] = "#"
          end
        end
        if opts[:confirm] then
          a_opts[:confirm] = opts[:confirm]
        end


                                                                        # process active option
        if opts[:active] != nil
          is_active = nil
          # check to see if many conditions are specified
          if opts[:active].is_a?(Array)
            condition_found = false
            # iterate over each
            opts[:active].each do |a|
              if defined?(a[:controller]) && a[:controller]
                if defined?(a[:active]) && a[:active]
                  if process_controller_action_active_condition(a)
                    condition_found = true
                  end
                else
                  if process_controller_action_active_condition(a)
                    condition_found = true
                  end
                end
              else
                raise "Unexpected active condition"
              end
            end
            is_active = condition_found
            #logger.debug("poly_condition #{opts[:active].to_json} #{is_active.to_json}")
          else
            is_active = process_active_condition(opts[:active])
          end

          if is_active
            li_opts[:class] += " active "
          end
        end


        if li_opts[:class] == ""
          li_opts.delete(:class)
        end
        if a_opts[:class] == ""
          a_opts.delete(:class)
        end

        if opts[:toggle] == :none
          a_opts.delete('data-toggle')
        end


        if content_inside_a
          display_name = display_name.concat(content_inside_a)
        end

        link_dest  = a_opts[:href] ? a_opts.delete(:href) : "#"
        a_content  = link_to(display_name.html_safe, link_dest, a_opts) #content_tag_string(:a, display_name.html_safe, a_opts)
                                                                        #Rails.logger.debug("a_hash #{a_opts}\t#{a_content}")
                                                                        # the <a> tag goes in the <li>
        li_content = a_content
        if content_inside_li # is there extra stuff to throw in there?
          li_content = li_content.concat(content_inside_li)
        end


        content_tag_string(:li, li_content, li_opts)
      end

      def build_drop_down_menu(dat)
        if !dat
          raise "No actions"
        end
        menu_items = ""
        dat.each do |item|
          display_name    = if item[:label] then
                              item[:label]
                            else
                              item[:id] ? item[:id].to_s.titlecase : "No Name"
                            end
          item[:dropdown] = false

          menu_items.concat(tab_tag(display_name, nil, nil, item.merge({ :toggle => :none })))
        end
        menu = content_tag_string(:ul, menu_items.html_safe, :class => "dropdown-menu")
        return menu
      end

      #
      #

      def process_active_condition(option)
        if option.is_a?(Array)
          raise "Option shouldn't be an array"
        end
        if option == true || option == false
          return option
        else
          if option[:controller] != nil
            res= process_controller_action_active_condition(option)
            #logger.debug("Controller condition #{option[:controller].to_s} = #{res.to_json}")
            return res
          end
        end
        raise "No controller specified"
      end

      def process_controller_action_active_condition(option)

        controller_pass = controller_name == option[:controller].to_s
        #logger.debug("Pass? #{controller_pass.to_json}")
        if option[:action] != nil
          return controller_pass && action_name == option[:action].to_s
        else
          return controller_pass
        end
      end
    end
  end
end