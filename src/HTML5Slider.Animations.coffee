@HTML5Slider.Animations = (type, onComplete) ->
    return @init type, onComplete

@HTML5Slider.Animations:: =
    init: (type, onComplete) ->
        return @[type].init onComplete

    leftRight:
        data: null

        reset: (onComplete) ->
            @data =
                left: 0
                onComplete: onComplete

        init: (onComplete) ->
            @reset onComplete

            return @

        hide: (child) ->
            child.style.left = '-100%'

        show: (child) ->
            child.style.left = '0%'

        run: (lastSlide, currSlide, setOn) ->
            setInterval (->
                if lastSlide.style.left is '-100%'
                    @data.left = 0
                    @data.onComplete setOn, lastSlide
                    return

                lastSlide.style.left = - @data.left + '%'
                currSlide.style.left = 100 - @data.left + '%'
                @data.left++
            ).bind(@), 1

    alpha:
        data: null

        reset: (onComplete) ->
            @data =
                alpha: 1
                onComplete: onComplete

        init: (onComplete) ->
            @reset onComplete

            return @

        hide: (child) ->
            child.style.opacity = 1

        show: (child) ->
            child.style.opacity = 0

        run: (lastSlide, currSlide, setOn) ->
            lastSlide.style.opacity = 1
            currSlide.style.opacity = 0

            setInterval (->
                if +lastSlide.style.opacity < 0
                    @data.alpha = 1
                    @data.onComplete setOn, lastSlide
                    return

                lastSlide.style.opacity = @data.alpha
                currSlide.style.opacity = 1 - @data.alpha
                @data.alpha -= 0.05
            ).bind(@), 10