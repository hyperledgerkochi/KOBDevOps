/*!
 * jQuery tabs - lucid style
 *
 * USAGE
 * // Basic Usage
 * $('.tabContainer').dock();
 * // Optional Parameters
 * $(selector).dock({
 *      large: false, // Use large text in tabs
 *      border: true
 *  });
 */


(function($) {
    $.fn.lucidtabs = function(settings) {
        var config = $.extend({
            large: false,
            narrow: false,
            border: true,
            contentSelector: 'div',
            contentCSS: {},
            buttons:[],
            tabChangeFilter: function(toTab, fromTab, changeTabs) { changeTabs(); }
        }, settings);
       
        this.each(function() {
            var panels = $(this).children(config.contentSelector)
                .addClass('lucid-tabs-content')
                .css(config.contentCSS);
           
            var list = $(this).children('ul');
           
            // If no list, generate one using titles from children divs
            if (list.length == 0) {
                list = $('<ul></ul>').prependTo($(this));
                panels.each(function() {
                    list.append('<li>' + $(this).attr('title') + '</li>');
                    $(this).removeAttr('title');
                });
            }
           
            var tabs = list.addClass('lucid-tabs').children('li');
           
            if (config.border)
                panels.addClass('lucid-tabs-content-framed');
               
            if (config.large)
                list.addClass('lucid-tabs-large');
            else if (config.narrow) {
                list.addClass('lucid-tabs-narrow');
            }
           
            panels.hide();
            tabs.each(function(i) {
                var me = this;

                var changeTabs = function() {
                    panels.hide().eq(i).show();
                    $(me).addClass('active').siblings('.active').removeClass('active');
                };

                $(this).click(function() {
                    if (config.tabChangeFilter &&
                        typeof config.tabChangeFilter == 'function' &&
                        !$(this).hasClass('active')) {

                        config.tabChangeFilter($(this).text(),
                                               $(this).siblings('.active').text(),
                                               changeTabs
                        );
                    }
                    else {
                        changeTabs();
                    }
                });
                if ($(this).hasClass('active'))
                    $(this).click();
            });
            if (tabs.filter('.active').length == 0)
                tabs.eq(0).click();
           
            list.prepend('<li class="first"></li>').append('<li class="last"></li>');
            for(var i = 0; i < config.buttons.length; i++) {
                if(config.buttons[i]) {
                    var button = $('<div class="tabbar-button"><div class="icn-21 icn-'+config.buttons[i].icon+'-inverted-inverse"></div></div>')
                        .attr('title', config.buttons[i].title)
                        .click(config.buttons[i].click);
                       
                    list.append(button);
                }
            }
           
            $(this).show();
        });

        return this;
    };
})(jQuery);