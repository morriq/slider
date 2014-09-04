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
        prev: null,
        withAnim: true,
        animType: 'leftRight'
      };
      this.data = {
        currSlide: 0,
        interval: null,
        children: [],
        width: 0,
        playingAnim: null
      };
      HTML5Slider.prototype.extend(this.config, config);
      this.config.obj.style.position = 'relative';
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
      return elem.addEventListener('click', action.bind(this, false));
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
      child.style.left = -100 % (child.style.alpha = 0);
      return child.style.display = 'none';
    },
    showChild: function(child, pos) {
      if (pos == null) {
        pos = 0;
      }
      child.style.left = pos;
      return child.style.display = 'block';
    },
    stepForward: function() {
      if (HTML5Slider.prototype.isPauseOnHover(this.config)) {
        return;
      }
      return this.nextSlide(this.config.withAnim);
    },
    prevSlide: function(anim) {
      return this.setSlide(this.data.currSlide - 1, anim);
    },
    nextSlide: function(anim) {
      return this.setSlide(this.data.currSlide + 1, anim);
    },
    resetAnim: function() {
      clearInterval(this.data.playingAnim);
      return this.data.playingAnim = null;
    },
    onChangeOver: function(setOn, lastSlide) {
      this.data.currSlide = setOn;
      this.hideChild(lastSlide);
      this.resetAnim();
      return this.setInterval();
    },
    setSlide: function(setOn, anim) {
      var chLength, currSlide, lastNumber, lastSlide, left;
      lastNumber = setOn - 1;
      chLength = this.data.children.length;
      left = 0;
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
      if (!anim || this.data.playingAnim) {
        this.showChild(currSlide);
        this.onChangeOver(setOn, lastSlide);
        return;
      }
      this.showChild(currSlide, '100%');
      return this.data.playingAnim = setInterval((function() {
        if (lastSlide.style.left === '-100%') {
          this.onChangeOver(setOn, lastSlide);
          return;
        }
        lastSlide.style.left = -left + '%';
        currSlide.style.left = 100 - left + '%';
        return left++;
      }).bind(this), 1);
    }
  };

}).call(this);

//# sourceMappingURL=HTML5Slider.Slide.map
