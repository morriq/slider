@HTML5Slider.Slide = (config) ->
    @init config

@HTML5Slider.Slide:: =
    config: {}

    data: {}

    init: (config) ->
        @config =
            obj:            null
            frameTime:      10
            pauseOnHover:   true
            next:           null
            prev:           null
            withAnim:       true
            animType:       'leftRight' # leftRight or alpha

        @data =
            currSlide:      0
            interval:       null
            children:       []
            width:          0
            playingAnim:    null
            anim:           null

        HTML5Slider.prototype.extend @config, config
        @config.obj.style.position = 'relative'
        @data.anim      = new HTML5Slider.Animations @config.animType, @onAnimationComplete.bind(@)
        @data.children  = HTML5Slider.prototype.getChildren @config.obj, @hideChild.bind(@)

        @setInterval()
        @initButtons()
        @setSlide 0

    setInterval: ->
        clearInterval @data.interval
        @data.interval = null

        @data.interval = setInterval @stepForward.bind(@), @config.frameTime

    initButton: (elem, action) ->
        elem.addEventListener 'click', action.bind(@, false)

    initButtons: ->
        @initButton @config.next, @prevSlide if @config.next
        @initButton @config.prev, @nextSlide if @config.prev

    hideChild: (child) ->
        @data.anim.hide child

        child.style.display = 'none'

    showChild: (child) ->
        @data.anim.show child

        child.style.display = 'block'

    stepForward: ->
        return if HTML5Slider.prototype.isPauseOnHover @config

        @nextSlide @config.withAnim

    prevSlide: (anim) ->
        @setSlide @data.currSlide - 1, anim

    nextSlide: (anim) ->
        @setSlide @data.currSlide + 1, anim

    resetAnim: ->
        clearInterval @data.playingAnim
        @data.playingAnim = null

    onChangeOver: (setOn, lastSlide) ->
        @data.currSlide = setOn
        @hideChild lastSlide
        @resetAnim()
        @setInterval()

    onAnimationComplete: (setOn, lastSlide) ->
        @onChangeOver setOn, lastSlide

    setSlide: (setOn, anim) ->
        lastNumber  = setOn - 1
        chLength    = @data.children.length

        if setOn > @data.currSlide
            lastNumber = setOn - 1
        else
            lastNumber = setOn + 1

        if setOn >= chLength
            setOn = 0
        else if setOn < 0
            setOn       = chLength - 1
            lastNumber  = 0
        else if setOn is 0 and setOn > @data.currSlide
            lastNumber = chLength - 1

        lastSlide   = @data.children[lastNumber]
        currSlide   = @data.children[setOn]

        if not anim or @data.playingAnim
            @showChild currSlide
            @onChangeOver setOn, lastSlide
            return

        @showChild currSlide
        @data.playingAnim = @data.anim.run lastSlide, currSlide, setOn