module Spurs
  module Flash

    module ControllerMods
      def flash_addItem(list_name, message)
        pluralized_list_name = list_name.to_s.pluralize.parameterize.to_sym
        if flash[pluralized_list_name].nil?
          flash[pluralized_list_name] = Array.new
        end
        flash[pluralized_list_name].push("<p>#{message}</p>")
      end

      #Array of
      # name
      # type (:link or :js)
      # action
      def flash_addItemWithActions(list_name, message, actions)
        if flash[list_name].nil?
          flash[list_name] = Array.new
        end
        flash_string = "<p>#{message}</p><div class=\"alert-actions\">"

        actions.each do |action|
          if action[:type] == :link
            flash_string = flash_string + "<a class=\"btn small\" href=\"#{action[:action]}\">#{action[:name]}</a>"
          end
        end

        flash_string = flash_string +"</div>"
        flash[list_name].push(flash_string)
      end

      def flash_addModelErrors(model)
        if flash[:errors].nil?
          flash[:errors] = Array.new
        end
        model.errors.each do |k, errs|
          flash[:errors].push("#{k.to_s} - #{errs.to_s}")
        end
      end
    end
  end
end