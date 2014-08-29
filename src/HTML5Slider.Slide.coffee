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

        @data =
            currSlide:      0
            interval:       null
            children:       []

        HTML5Slider.prototype.extend @config, config
        @data.children = HTML5Slider.prototype.getChildren @config.obj, @hideChild

        @setInterval()
        @initButtons()
        @setSlide 0

    setInterval: ->
        clearInterval @data.interval
        @data.interval = null

        @data.interval = setInterval @stepForward.bind(@), @config.frameTime

    initButton: (elem, action) ->
        elem.addEventListener 'click', action.bind(@)

    initButtons: ->
        @initButton @config.next, @nextSlide if @config.prev
        @initButton @config.prev, @prevSlide if @config.prev

    hideChild: (child) ->
        child.style.display = 'none'

    showChild: (child) ->
        child.style.display = 'block'

    stepForward: ->
        return if HTML5Slider.prototype.isPauseOnHover @config

        @nextSlide()

    prevSlide: ->
        @setSlide @data.currSlide - 1

    nextSlide: ->
        @setSlide @data.currSlide + 1

    setSlide: (setOn) ->
        @setInterval()

        lastNumber  = setOn - 1
        chLength    = @data.children.length

        if setOn >= chLength
            setOn = 0
        else if setOn < 0
            setOn       = chLength - 1
            lastNumber  = 0
        else if setOn is 0
            lastNumber = chLength - 1

        lastSlide   = @data.children[lastNumber]
        currSlide   = @data.children[setOn]

        @data.currSlide = setOn
        @hideChild lastSlide
        @showChild currSlide