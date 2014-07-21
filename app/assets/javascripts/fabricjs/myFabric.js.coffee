ready = ->
    canvas = window._canvas = new fabric.Canvas 'canvas'
    canvas.backgroundColor = '#fff'
    canvas.setHeight 500
    canvas.setWidth 500

    canvas.renderAll
    canvas.isDrawingMode = !canvas.isDrawingMode
    canvas.freeDrawingBrush.width = 10
    canvas.freeDrawingBrush.color = "#000"
    colorBox = $('.brush-color-controller .color-option')
    widthButton = $('.brush-width-controller .width-option')

    colorBox.click(
        ->
            color = $(@).css 'background-color'
            canvas.freeDrawingBrush.color = color
            unglowBorder colorBox
            colorBox.removeClass 'active'
            glowBorder $(@)
            $(@).addClass "active"
        )

    colorBox.hover(
        ->
            glowBorder($(@))
        ->
            unless $(@).hasClass "active"
                unglowBorder($(@))
        )

    widthButton.click(
        ->
            width = $(@).data "width"
            canvas.freeDrawingBrush.width = width
            removeBorder widthButton
            addBottomBorder($(@))
        )

    $('.save-picture-btn').click(
        (e) ->
            svg = canvas.toSVG()
            data = svg: svg
            $.post '/rounds/create_drawing', data, (response) ->
                console.log 'done'
                location.href = '/'
        )

$(document).ready(ready)
$(document).on('page:load', ready)

unglowBorder = (selector) ->
    selector.removeAttr 'outline'
    selector.css 'border-color', '#000'
    selector.removeAttr 'box-shadow'

glowBorder = (selector) ->
    selector.css('outline', 'none')
    selector.css('border-color', '#9ecaed')
    selector.css('box-shadow', '0 0 10px #9ecaed')

removeBorder = (selector) ->
    selector.css 'border-bottom', '0 solid black'

addBottomBorder = (selector) ->
    selector.css 'border-bottom', '3px solid black'














