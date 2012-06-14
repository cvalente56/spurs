require "spurs/modal/builder"
module Spurs
  module Modal
    module Helper
      def spurs_modal(file_or_partial, object=nil, options={ })
        opts          = Spurs::Modal::default_options.merge(options)
        builder_class = opts.delete(:builder)
        builder       = builder_class.new

        modal_id = "modal_#{SecureRandom::hex(5)}"

        options_for_content = options[:content_options] ? options.delete(:content_options) : { }
        #logger.debug "ContentOptions: #{options_for_content}"
        if object == nil
          content = render :file => file_or_partial, :locals => options_for_content
        else
          content = render :object => object, :partial => file_or_partial, :locals => options_for_content
        end


        bm = builder.build_modal(modal_id, content, options)
      end
    end
  end
end