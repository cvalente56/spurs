module Spurs
  module Modal
    module ControllerMods
      extend ActiveSupport::Concern

      def spawn_form_modal(title, partial, object, options={ })
        opts = {
            :actions => [
                { :name => :cancel, :position => :left, :action => :close_modal, :class => "btn-large" },
                { :name => :save, :position => :right, :action => :submit_form_and_close_modal, :class => "btn-primary btn-large" },
            ]
        }.merge(options)
        spawn_modal(title, partial, object, opts)
      end



      def spawn_close_modal(title, file, options={ })
        opts = {
            :actions => [
                { :name => :cancel, :position => :left, :action => :close_modal, :class => "btn-large" }
            ]
        }.merge(options)
        spawn_modal(title, file, nil, opts)
      end



      def spawn_modal(title, partial, object, options={ })

        opts = {
            :header => {
                :title => title.titlecase,
                :icon  => options[:title_icon] ? options.delete(:title_icon) : nil
            },

        }.merge(options)

        render :file => "spurs/modals/spawn", :locals => {  :modal_file_or_partial => partial,
                                                            :modal_object          => object,
                                                            :modal_options         => opts }
      end
    end
  end
end