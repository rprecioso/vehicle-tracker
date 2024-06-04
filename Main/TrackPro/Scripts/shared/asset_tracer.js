
$('.trace-btn-asset').text("Trace Asset");
$('.trace-btn-asset').click(function () {

    if ($(this).text() == "Clear") {
        $(this).text("Trace Asset");
    }
    else {
        $(this).text("Clear");
    }
    
});
