(function() {
  $(function() {
    var checkScrollTop, checkWideScreen, fixNav, getOffset, getWidth, mobList, mobNav, screenOffset, scrollMaster, slideScroll, timer, topJump, wideScreen;
    fixNav = $('#fixed-nav');
    topJump = $('.top-jump');
    mobList = $('.mobile-nav-list');
    mobNav = $('.mobile-nav');
    wideScreen = false;
    screenOffset = false;
    getWidth = function() {
      var pageWidth;
      return pageWidth = $(window).width();
    };
    getOffset = function() {
      var pageOffset;
      return pageOffset = window.pageYOffset;
    };
    checkScrollTop = function(offset) {
      if (offset > 550 && screenOffset === false) {
        screenOffset = true;
        topJump.addClass("top-jump-active");
        topJump.animate({
          opacity: 1
        }, 1000);
      }
      if (offset < 550 && screenOffset === true) {
        screenOffset = false;
        topJump.removeClass("top-jump-active");
        return topJump.animate({
          opacity: 0
        }, 500);
      }
    };
    checkWideScreen = function(width) {
      if (width > 641 && wideScreen === false) {
        wideScreen = true;
      }
      if (width < 641 && wideScreen === true) {
        wideScreen = false;
      }
      if (wideScreen === true && screenOffset === true) {
        return fixNav.fadeIn();
      } else {
        return fixNav.fadeOut();
      }
    };
    timer = void 0;
    $(window).scroll(function() {
      if (timer) {
        window.clearTimeout(timer);
      }
      return timer = window.setTimeout(function() {
        checkScrollTop(getOffset());
        return checkWideScreen(getWidth());
      }, 25);
    });
    $(window).resize(function() {
      if (timer) {
        window.clearTimeout(timer);
      }
      return timer = window.setTimeout(function() {
        return checkWideScreen(getWidth());
      }, 100);
    });
    slideScroll = function(element, navheight) {
      var offset, offsetTop, root, totalScroll;
      root = $("body,html");
      offset = element.offset();
      offsetTop = offset.top;
      totalScroll = offsetTop - navheight;
      return root.animate({
        scrollTop: totalScroll
      }, 800);
    };
    scrollMaster = function(element, mod) {
      var el, elWrap;
      el = $(element).attr("href");
      elWrap = $(el);
      slideScroll(elWrap, mod);
      return false;
    };
    topJump.on("click", function() {
      return scrollMaster($(this), 45);
    });
    return mobList.on("click", "a", function() {
      mobNav.removeClass("expanded");
      return scrollMaster($(this), 0);
    });
  });

  $(function() {
    (function($, window, undefined_) {
      "use strict";
      $.CatSlider = function(options, element) {
        this.$el = $(element);
        this._init(options);
      };
      $.CatSlider.prototype = {
        _init: function(options) {
          var $currcat, animEndEventNames;
          this.$categories = this.$el.children("ul");
          this.$navcategories = this.$el.find("nav > a");
          animEndEventNames = {
            WebkitAnimation: "webkitAnimationEnd",
            OAnimation: "oAnimationEnd",
            msAnimation: "MSAnimationEnd",
            animation: "animationend"
          };
          this.animEndEventName = animEndEventNames[Modernizr.prefixed("animation")];
          this.support = Modernizr.csstransforms && Modernizr.cssanimations;
          this.isAnimating = false;
          this.current = 0;
          $currcat = this.$categories.eq(0);
          if (!this.support) {
            this.$categories.hide();
            $currcat.show();
          } else {
            $currcat.addClass("serv-current");
          }
          this.$navcategories.eq(0).addClass("serv-selected");
          this._initEvents();
        },
        _initEvents: function() {
          var self;
          self = this;
          this.$navcategories.on("click.catslider", function() {
            self.showCategory($(this).index());
            return false;
          });
          $(window).on("resize", function() {
            self.$categories.removeClass().eq(0).addClass("serv-current");
            self.$navcategories.eq(self.current).removeClass("serv-selected").end().eq(0).addClass("serv-selected");
            self.current = 0;
          });
        },
        showCategory: function(catidx) {
          var $currcat, $newcat, $newcatchild, dir, fromClass, lastEnter, self, toClass;
          if (catidx === this.current || this.isAnimating) {
            return false;
          }
          this.isAnimating = true;
          this.$navcategories.eq(this.current).removeClass("serv-selected").end().eq(catidx).addClass("serv-selected");
          dir = (catidx > this.current ? "right" : "left");
          toClass = (dir === "right" ? "serv-moveToLeft" : "serv-moveToRight");
          fromClass = (dir === "right" ? "serv-moveFromRight" : "serv-moveFromLeft");
          $currcat = this.$categories.eq(this.current);
          $newcat = this.$categories.eq(catidx);
          $newcatchild = $newcat.children();
          lastEnter = (dir === "right" ? $newcatchild.length - 1 : 0);
          self = this;
          if (this.support) {
            $currcat.removeClass().addClass(toClass);
            setTimeout((function() {
              $newcat.removeClass().addClass(fromClass);
              $newcatchild.eq(lastEnter).on(self.animEndEventName, function() {
                var $this;
                $(this).off(self.animEndEventName);
                $newcat.addClass("serv-current");
                self.current = catidx;
                $this = $(this);
                self.forceRedraw($this.get(0));
                self.isAnimating = false;
              });
            }), $newcatchild.length * 90);
          } else {
            $currcat.hide();
            $newcat.show();
            this.current = catidx;
            this.isAnimating = false;
          }
        },
        forceRedraw: function(element) {
          var n, position;
          if (!element) {
            return;
          }
          n = document.createTextNode(" ");
          position = element.style.position;
          element.appendChild(n);
          element.style.position = "relative";
          setTimeout((function() {
            element.style.position = position;
            n.parentNode.removeChild(n);
          }), 25);
        }
      };
      $.fn.catslider = function(options) {
        var args, instance;
        instance = $.data(this, "catslider");
        if (typeof options === "string") {
          args = Array.prototype.slice.call(arguments_, 1);
          this.each(function() {
            instance[options].apply(instance, args);
          });
        } else {
          this.each(function() {
            if (instance) {
              instance._init();
            } else {
              instance = $.data(this, "catslider", new $.CatSlider(options, this));
            }
          });
        }
        return instance;
      };
    })(jQuery, window);
    return $("#serv-slide").catslider();
  });

}).call(this);
