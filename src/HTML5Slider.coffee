@HTML5Slider = (config) ->
    new HTML5Slider[@getBuilder config] config

@HTML5Slider:: =
    extend: (pObj, pVal) ->
        for i of pVal
            pObj[i] = pVal[i]

    getChildren: (elem, callback) ->
        children = elem.children
        chLength = children.length

        throw new Error elem.id + ' - children not found' unless chLength
        console.warn 'only one child in ' + elem.id if chLength is 1

        return children unless callback

        i = 0
        while i < chLength
            callback children[i]
            i++

        children

    isPauseOnHover: (config) ->
        return false unless config.pauseOnHover

        return true if config.obj.parentElement.querySelector(':hover') is config.obj

    getBuilder: (config) ->
        name = 'Slide'
        if config.type is 'scrollX'
            name = 'ScrollX'
        else if config.type is 'scrollY'
            name = 'ScrollY'

        name