
//function to call the marine weather data
function getMarineData(latitude, longitude) {

    $.ajax({
        url: _getMarineWeatherData,
        type: 'post',
        data: { "Longitude": longitude, "Latitude": latitude },
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            satvm.MarineData(rdt);
        },
        error: function (e) {
            if (e != null) {
                var err = eval("(" + e.responseText + ")");
                createAlert('Marine Data Warning: No more queries left.','danger');
            }
            else {
                createAlert('Internal Server Error. Please contact your administrator.', 'warning');
            }
        }
    });
}