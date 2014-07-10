var ready;
ready = function() {

    var canvas;

    canvas = window._canvas = new fabric.Canvas('canvas');
    canvas.backgroundColor = '#efefef';
    canvas.setHeight(500);
    canvas.setWidth(500);

    canvas.renderAll();
    canvas.isDrawingMode = !canvas.isDrawingMode;
    canvas.freeDrawingBrush.width = 11;
    canvas.freeDrawingBrush.color = "#fff";

    $('.brush-color-controller .color-option').click(function(){
        var color = $(this).css('background-color')
        canvas.freeDrawingBrush.color = color
        unglowAllBorders($('.brush-color-controller .color-option'))
        glowBorder($(this))
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


var unglowAllBorders = function(selector) {
    selector.removeAttr('outline');
    selector.css('border-color', '#000')
    selector.removeAttr('box-shadow')
}

var glowBorder = function(selector) {
    selector.css('outline', 'none')
    selector.css('border-color', '#9ecaed')
    selector.css('box-shadow', '0 0 10px #9ecaed')
}










