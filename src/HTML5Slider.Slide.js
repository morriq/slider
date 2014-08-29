// Generated by CoffeeScript 1.7.1
(function() {
  this.HTML5Slider.Slide = function(config) {
    return this.init(config);
  };

  this.HTML5Slider.Slide.prototype = {
    config: {},
    data: {},
    init: function(config) {
      this.config = {
        obj: null,
        frameTime: 10,
        pauseOnHover: true,
        next: null,
        prev: null
      };
      this.data = {
        currSlide: 0,
        interval: null,
        children: []
      };
      HTML5Slider.prototype.extend(this.config, config);
      this.data.children = HTML5Slider.prototype.getChildren(this.config.obj, this.hideChild);
      this.setInterval();
      this.initButtons();
      return this.setSlide(0);
    },
    setInterval: function() {
      clearInterval(this.data.interval);
      this.data.interval = null;
      return this.data.interval = setInterval(this.stepForward.bind(this), this.config.frameTime);
    },
    initButton: function(elem, action) {
      return elem.addEventListener('click', action.bind(this));
    },
    initButtons: function() {
      if (this.config.prev) {
        this.initButton(this.config.next, this.nextSlide);
      }
      if (this.config.prev) {
        return this.initButton(this.config.prev, this.prevSlide);
      }
    },
    hideChild: function(child) {
      return child.style.display = 'none';
    },
    showChild: function(child) {
      return child.style.display = 'block';
    },
    stepForward: function() {
      if (HTML5Slider.prototype.isPauseOnHover(this.config)) {
        return;
      }
      return this.nextSlide();
    },
    prevSlide: function() {
      return this.setSlide(this.data.currSlide - 1);
    },
    nextSlide: function() {
      return this.setSlide(this.data.currSlide + 1);
    },
    setSlide: function(setOn) {
      var chLength, currSlide, lastNumber, lastSlide;
      this.setInterval();
      lastNumber = setOn - 1;
      chLength = this.data.children.length;
      if (setOn >= chLength) {
        setOn = 0;
      } else if (setOn < 0) {
        setOn = chLength - 1;
        lastNumber = 0;
      } else if (setOn === 0) {
        lastNumber = chLength - 1;
      }
      lastSlide = this.data.children[lastNumber];
      currSlide = this.data.children[setOn];
      this.data.currSlide = setOn;
      this.hideChild(lastSlide);
      return this.showChild(currSlide);
    }
  };

}).call(this);

//# sourceMappingURL=HTML5Slider.Slide.map
