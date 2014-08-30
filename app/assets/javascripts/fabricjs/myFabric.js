var ready;
ready = function() {
    var canvas;

    canvas = window._canvas = new fabric.Canvas('canvas');
    canvas.backgroundColor = '#fff';
    canvas.setHeight(500);
    canvas.setWidth(500);

    canvas.renderAll();
    canvas.isDrawingMode = !canvas.isDrawingMode;
    canvas.freeDrawingBrush.width = 10;
    canvas.freeDrawingBrush.color = "#000";
    var colorBox = $('.brush-color-controller .color-option')
    var widthButton = $('.brush-width-controller .width-option')

    colorBox.click(function(){
        var color = $(this).css('background-color')
        canvas.freeDrawingBrush.color = color
        unglowBorder(colorBox)
        colorBox.removeClass("active")
        glowBorder($(this))
        $(this).addClass("active")

    });

    colorBox.hover(
        function() {
            glowBorder($(this))
        }, function() {
            if (!$(this).hasClass("active")) {
                unglowBorder($(this))
            }
        })

    widthButton.click(function(){
        var width = $(this).data("width")
        canvas.freeDrawingBrush.width = width
        removeBorder(widthButton)
        addBottomBorder($(this))
    })

    $('.save-picture-btn').click(function(e) {
        var svg = canvas.toSVG();
        var data = {svg: svg};
        $.post('/rounds/create_drawing', data, function(response) {
            location.href = '/';
        })
    })

};

$(document).ready(ready);
$(document).on('page:load', ready);


var unglowBorder = function(selector) {
    selector.removeAttr('outline');
    selector.css('border-color', '#000')
    selector.removeAttr('box-shadow')
}

var glowBorder = function(selector) {
    selector.css('outline', 'none')
    selector.css('border-color', '#9ecaed')
    selector.css('box-shadow', '0 0 10px #9ecaed')
}

var removeBorder = function(selector) {
    selector.css("border-bottom", "0 solid black")
}

var addBottomBorder = function(selector) {
    selector.css("border-bottom", "3px solid black")
}







