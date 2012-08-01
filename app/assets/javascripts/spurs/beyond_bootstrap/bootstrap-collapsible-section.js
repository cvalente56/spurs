/**
 * jQuery Collapsible Section
 * (c) 2012 Michael North
 */
(function( $ ){

    $.fn.collapsibleSection = function( options ) {

        // Create some defaults, extending them with any options that were provided
        var settings = $.extend({
            collapseText         :'collapse',
            expandText           :'click to expand',
            headerClass          :'section-header',
            bodyClass            :'section-body',
            footerClass          :'section-footer',
            endClass             :'collapsible-section-end',
            sectionComponentClass:'collapsible-section-component'

        }, options);

        var private_methods = {
            expandSection: function() {
                $(this).removeClass('collapsed');
                $(this).addClass('expanded');
            },
            collapseSection: function() {
                $(this).addClass('collapsed');
                $(this).removeClass('expanded');
            }
        };

        return this.each(function(idx,item) {
            //if no collapsed or expanded class is present, collapse it
            if(!$(item).hasClass('collapsed') && !$(item).hasClass('expanded')) {
                $(item).addClass('collapsed');
            }

            //create end
            var end_element = document.createElement("div");
            $(end_element).addClass(settings.endClass);

            var end_element_message = document.createElement('div');
            $(end_element_message).addClass("message").append(settings.expandText);
            var fadestripe = document.createElement("div");
            $(fadestripe).addClass('fadestripe');
            $(fadestripe).append("&nbsp;");
            end_element.appendChild(end_element_message);
            end_element.appendChild(fadestripe);

            $(item).append(end_element);

            //add section-component class to header, body and end
            $(item).find('.' + settings.bodyClass).addClass(settings.sectionComponentClass);
            $(item).find('.' + settings.footerClass).addClass(settings.sectionComponentClass);
            $(item).find('.' + settings.endClass).addClass(settings.sectionComponentClass);

            //add collapse button
            var collapse_button = document.createElement('a');
            $(collapse_button).addClass('collapse-trigger');
            $(collapse_button).click(function(){
                private_methods.collapseSection.apply(item);
            });
            $(collapse_button).append(settings.collapseText);
            $(item).find('.' + settings.headerClass)[0].appendChild(collapse_button);

            $(item).find('.'+settings.sectionComponentClass).click(function(){
                private_methods.expandSection.apply(item);
            });
        });

    };
})( jQuery );