module Spurs
  module Nav
    module Helper


      # Build a navigation
      # :type can be either :pills or :tabs
      # :style applies to ul
      def spurs_nav(options={ }, &block)

        opts        = Spurs::Nav::nav_default_options.merge(options)
        if !opts[:builder]
          raise "Null builder"
        end

        opts_to_pass_to_builder = {}
        if opts[:dynamic]
          opts_to_pass_to_builder[:dynamic] = opts[:dynamic]
        end

        if !opts[:type].in? [:pills,:tabs,:list]
          Rails.logger.debug("WARNING: unknown spurs_nav flavor. Using tabs instead")
          opts[:type] = :tabs
        end

        nav_builder = opts[:builder].new(controller,opts_to_pass_to_builder)

        output = capture(nav_builder, &block)

        ul_args = {
            :class => "nav nav-#{opts[:type]} #{opts[:stacked] ? "nav-stacked" : ""} #{opts[:class] ? opts[:class] : ""}"
        }

        if defined?(opts[:style]) then
          ul_args[:style] = opts[:style]
        end

        content_tag_string(:ul, output, ul_args)
      end
    end
  end
end