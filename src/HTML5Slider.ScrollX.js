// Generated by CoffeeScript 1.7.1
(function() {
  this.HTML5Slider.ScrollX = function(config) {
    return this.init(config);
  };

  this.HTML5Slider.ScrollX.prototype = {
    config: {},
    data: {
      init: function(config) {
        this.config = {
          obj: null,
          frameTime: 10,
          pauseOnHover: true,
          height: null,
          width: null
        };
        this.data = {
          interval: null,
          children: [],
          totalWidth: 0,
          totalHeight: 0,
          top: 0,
          right: 0,
          timer: 0,
          marker: 1
        };
        HTML5Slider.prototype.extend(this.config, config);
        this.data.children = HTML5Slider.prototype.getChildren(this.config.obj);
        return this.data.interval = setInterval(this.stepForward, 1);
      },
      stepForward: function() {
        this.data.timer++;
        if (HTML5Slider.prototype.isPauseOnHover(this.config)) {
          return;
        }
        if (this.data.timer < this.config.frameTime) {
          return;
        }
        this.data.timer = 0;
        return this.moveSlider();
      },
      moveSlider: function() {}
    }
  };


  /*
          scrollInitHelper: function() {
          this.data.obj.innerHTML = '<div id="slider-helper" style="position: relative;">' + this.data.obj.innerHTML + '</div>';
  
          this.data.helper = document.getElementById('slider-helper');
      },
  
      scrollXInit: function() {
          // scrollX - container defined width and overflow-x: hidden
          this.scrollInitHelper();
  
          this.data.totalWidth = this.data.obj.offsetWidth;
          this.data.obj.style.overflowX = 'hidden';
  
          if (null === this.params.width) {
              this.params.width = this.data.totalWidth * .3;
          }
  
          this.data.obj.style.width = this.params.width + 'px';
      },
  
      scrollXEffect: function() {
          if (this.data.right < -this.data.totalWidth || this.data.right > this.params.width) {
              this.data.marker = +!this.data.marker;
          }
  
          this.data.right -= (1 === this.data.marker) ? 1 : -1;
  
          this.data.helper.style.right = this.data.right + 'px';
      },
  
      scrollYInit: function() {
          // scrollY - container defined height and overflow-y: hidden
          this.scrollInitHelper();
  
          this.data.totalHeight = this.data.obj.offsetHeight;
          this.data.obj.style.overflowY = 'hidden';
  
          if (null === this.params.height) {
              this.params.height = this.data.totalHeight * .3;
          }
  
          this.data.obj.style.height = this.params.height + 'px';
      },
  
      scrollYEffect: function() {
          if (this.data.top < -this.data.totalHeight || this.data.top > this.params.height) {
              this.data.marker = +!this.data.marker;
          }
  
          this.data.top -= (1 === this.data.marker) ? 1 : -1;
  
          this.data.helper.style.top = this.data.top + 'px';
      },
   */

}).call(this);

//# sourceMappingURL=HTML5Slider.ScrollX.map
