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

    $('.brush-color-controller .color-option').click(function(){
        var color = $(this).css('background-color')
        canvas.freeDrawingBrush.color = color
        unglowBorder($('.brush-color-controller .color-option'))
        $('.brush-color-controller .color-option').removeClass("active")
        glowBorder($(this))
        $(this).addClass("active")

    });

    $('.brush-color-controller .color-option').hover(
        function() {
            glowBorder($(this))
        }, function() {
            if (!$(this).hasClass("active")) {
                unglowBorder($(this))
            }
        })

    $('.brush-width-controller .width-option').click(function(){
        var width = $(this).data("width")
        canvas.freeDrawingBrush.width = width
        removeBorder($('.brush-width-controller .width-option'))
        addBottomBorder($(this))
    })

    // $('#brush-width')[0].addEventListener('change', function(e) {
    //     canvas.freeDrawingBrush.width = 2 + parseInt($(this).val()) * 3;
    //     console.log("width: " + canvas.freeDrawingBrush.width)
    // })

    // $('#save').click(function(e) {
    //     var svg = canvas.toSVG();
    //     var data = {svg: svg};
    //     $.post('/draw', data, function(response) {
    //         console.log('done');
    //         window.location.href = '/';
    //     })

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







