$(function() {
    $('.simple_color_kitchen_sink').simpleColor({
        boxHeight: 40,
        cellWidth: 20,
        cellHeight: 20,
        chooserCSS: { 'border': '1px solid #660033' },
        displayCSS: { 'border': '1px solid red' },
        displayColorCode: true,
        livePreview: true,
        onSelect: function(hex, element) {
            // alert("You selected #" + hex + " for input #" + element.attr('class'));
        },
        onCellEnter: function(hex, element) {
            // console.log("You just entered #" + hex + " for input #" + element.attr('class'));
        },
        onClose: function(element) {
            // alert("color chooser closed for input #" + element.attr('class'));
        }
    });
})  