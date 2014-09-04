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
            playingAnim:  null

        HTML5Slider.prototype.extend @config, config
        @config.obj.style.position = 'relative'
        @data.children  = HTML5Slider.prototype.getChildren @config.obj, @hideChild

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
        @initButton @config.next, @nextSlide if @config.prev
        @initButton @config.prev, @prevSlide if @config.prev

    hideChild: (child) ->
        child.style.left    = -100%
        child.style.alpha   = 0
        child.style.display = 'none'

    showChild: (child, pos = 0) ->
        child.style.left = pos
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

    setSlide: (setOn, anim) ->
        lastNumber  = setOn - 1
        chLength    = @data.children.length
        left        = 0

        if setOn >= chLength
            setOn = 0
        else if setOn < 0
            setOn       = chLength - 1
            lastNumber  = 0
        else if setOn is 0
            lastNumber = chLength - 1

        lastSlide   = @data.children[lastNumber]
        currSlide   = @data.children[setOn]

        if not anim or @data.playingAnim
            @showChild currSlide
            @onChangeOver setOn, lastSlide
            return

        @showChild currSlide, '100%'
        @data.playingAnim = setInterval (->
            if lastSlide.style.left is '-100%'
                @onChangeOver setOn, lastSlide
                return

            lastSlide.style.left = -left + '%'
            currSlide.style.left = 100 - left + '%'
            left++
        ).bind(@), 1