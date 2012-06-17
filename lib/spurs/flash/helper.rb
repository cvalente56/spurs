module Spurs
  module Flash
    module Helper
      # the default css class of the container for flash messages
      @@flashes_container_class = "spurs_flash_messages"


      def self.flashes_container_class
        @@flashes_container_class
      end


      # the prefix of the id for containers for flash messages
      @@flashes_container_id_prefix = "spurs_flash_messages_"


      def self.flashes_container_id_prefix
        @@flashes_container_id_prefix
      end


      @@default_messages_options = {
          :priority => 10,
          :builder  => Spurs::Flash::Builder
      }


      def self.default_messages_options
        @@class.default_messages_options
      end

      def spurs_alert_box(options={ }, &block)
        extra_class   = options[:type] ? "alert-#{options[:type]}" : ""
        alert_content = String.new
        if options[:title]
          alert_content.concat(content_tag(:h4, options[:title], :class => 'alert-heading'))
        end
        if block
          block_content = capture(nil, &block)
          alert_content.concat(block_content)
        end
        content_tag(:div, alert_content.html_safe, :class => "alert alert-block #{extra_class}")
      end

      def logger
        Rails.logger
      end
      ##
      # Generate HTML for flash messages
      # = Examples
      #
      #   spurs_flash_helper
      #
      # = Options
      #
      #   :priority - a numeric value that determines where new (usually dynamic) flash messages are placed. Defaults to 10
      def spurs_flash_helper(options={ })

        my_options   = @@default_messages_options.merge(options)

        #Rails.logger.debug("FLASH >>#{flash.to_json}")

        message_hash = Hash.new()


        flash.each do |fl|
          process_flash_message(fl, message_hash)
        end
        flash.clear

        #logger.debug("MESSAGE HASH >>#{message_hash.to_json}")


        #process the message hash now
        content = String.new
        message_hash.each do |k, v_arr|
          v_arr.each do |v|
            if v == nil
              logger.warn("Flash key with no value: #{k.to_s} in flash hash #{v_arr.to_json}")
            else
              content << spurs_alert(v, :flavor => k, :builder => my_options[:builder], :title => k.to_s.singularize.tableize.to_sym.to_s.titlecase)
            end
          end
        end

        content_tag(:div, content.html_safe, :class => @@flashes_container_class, :id => "#{@@flashes_container_id_prefix}#{my_options[:priority]}")
      end


      def spurs_alert(message, options={ })

        ## We shouldn't really need this if code is written properly
        if message.is_a?(Array)
          raise "Message shouldn't be an array #{message}"
        end

        #merge arguments with defaults
        my_options = Spurs::Flash::default_args[:default].merge(options)

        # make sure the flavor is a symbol
        if my_options[:flavor] then
          my_options[:flavor] = my_options[:flavor].to_s.singularize.parameterize.to_sym
        end

        # attempt to find the flavor in the list of known stuff
        if Spurs::Flash::flavors.find_index(my_options[:flavor]) == nil
          # didn't find it.
          logger.warn("Unknown flash flavor \"#{my_options[:flavor]}\". Using a default instead")
          my_options[:flavor] = Spurs::Flash::default_args[:default][:flavor]
        end


        if !my_options[:title_icon]
          ico = Spurs::Flash::flavor_icons[my_options[:flavor]]
          if ico then
            my_options[:title_icon] = ico
          end
        end

        if !my_options[:title]
          t = Spurs::Flash::flavor_titles[my_options[:flavor]]
          if t then
            my_options[:title] = t
          end
        end

        if !my_options[:builder]
          raise "Null builder"
        end

        builder = my_options[:builder].new

        begin
          flash_content = builder.build_alert(message, my_options)
        rescue => e
          raise "Problem building flash message \nMessage: #{message.to_json}\nOptions: #{my_options.to_json}\nCause: #{e.message}\n\t#{e.backtrace}"
        end

        return flash_content
      end


      private
      def process_flash_message(fl, message_hash)
        raw_key   = fl[0].to_s.parameterize.to_sym #normalize case
        is_plural = raw_key.to_s.pluralize == raw_key.to_s

        key = is_plural ? raw_key.to_s.singularize.to_s.parameterize.to_s : raw_key
                                                   # create the entry in the message hash if necessary
        if !message_hash[key]
          message_hash[key] = Array.new
        end

        if !is_plural
          message_hash[key].push(fl[1])
        else
          (0..fl[1].size-1).each do |i|
            message_hash[key].push(fl[1][i])
          end
        end
      end
    end
  end
end