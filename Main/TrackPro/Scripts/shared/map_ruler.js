//LESTER
//Title: Map Ruler
//Description: Create/display ruler and compute distance
//Required Libraries:
//Last Update: 2015-08-07


var markers = [];
var markerDistanceList = [];
var markerLabels = [];
var Lines = [];
var line = [];
var segments = [];
var markerLimit = 9;
//create invisible marker
var mousemarker = new google.maps.Marker({
    //position: point,
    map: map,
    visible: false,
});

var rulerMarker = function (name, rulerlength, latitude, longitude, m) {
    this.name = name;
    this.rulerlength = rulerlength;
    this.latitude = latitude;
    this.longitude = longitude;
    this.m = m
}

var straightHandler = function () {

    functionOn('ruler');
    $('.ruler-btn-snap').attr("disabled", "disabled");
    $('.ruler-btn-snap').text("Snap to Road");
    var text = $(this).text();
    if (text == "Clear") {
        rulerOff();
        $('.ruler-btn-snap').removeAttr('disabled');
        $(this).text("Straight Ruler");
        $('.measure-route-panel').children().next().hide();
        satvm.RouteList([]);
        $('#map-ruler-total').text('0 m');
        $('.ruler-btn-snap').bind("click", snapHandler);
    } else {
        $('.ruler-btn-snap').unbind();
        rulerStraight();
        $(this).text("Clear");
    }


}

var snapHandler = function () {

    functionOn('ruler');
    $('.ruler-btn-straight').attr("disabled", "disabled");
    $('.ruler-btn-straight').text("Straight Ruler");
    var text = $(this).text();
    if (text == "Clear") {
        rulerOff();
        $('.ruler-btn-straight').removeAttr('disabled');
        $(this).text("Snap to Road");
        $('.measure-route-panel').children().next().hide();
        satvm.RouteList([]);
        $('#map-ruler-total').text('0 m');
        $('.ruler-btn-straight').bind("click", straightHandler);
    } else {
        $('.ruler-btn-straight').unbind();
        rulerSnap();
        $(this).text("Clear");
    }


}

$('.ruler-btn-snap').text("Snap to Road");
$('.ruler-btn-straight').text("Straight Ruler");
$('.ruler-btn-snap').bind("click", snapHandler);
$('.ruler-btn-straight').bind("click", straightHandler);


function rulerOff() {
    google.maps.event.clearListeners(map, 'click');
    markerLabels.forEach(function (h) {
        h.setMap(null);
    });

    markers.forEach(function (m) {
        m.setMap(null);
    })
    markers.length = 0;
    Lines.forEach(function (n) {
        n.setMap(null);
    })
    segments = [];
    markers = [];
    line.setPath([]);
}

var myLabel = new overlayLabel(); //overlay Label for marker hover
myLabel.span_.style.cssText = 'position: relative; left: -50%; top: -30px; ' +
                         'white-space: nowrap;font-size:13px;font-weight:600;' +
                         'padding: 2px;text-shadow: 2px 0px 1px rgba(101, 129, 165, 1);';
function getSegmentsPath(z) {
    var a, c, arr = [];
    if (z) { var len = markers.length - z; } else { len = markers.length; }

    for (c = 0; c < len; c++) {
        a = segments[c];

        if (a && a.routes) {
            arr = arr.concat(a.routes[0].overview_path);
        }
    }
    return arr;
}
function addSegment(start, end, segIdx) {
    var markerDistanceList = [];
    service.route(
        {
            origin: start,
            destination: end,
            travelMode: google.maps.DirectionsTravelMode.DRIVING
        },
        function (result, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                segments[segIdx] = result;
                line.setPath(getSegmentsPath());
            }
        }
    );
}

function rulerSnap() {
    service = new google.maps.DirectionsService(),
    //initialize ruler
    line = new google.maps.Polyline({
        map: map,

        strokeColor: "#e65c00",
        strokeOpacity: 3,
        strokeWeight: 2
    });
    //Add Event Listener for Ruler
    google.maps.event.addListener(map, 'click', function (event) {
        var evtPos = event.latLng;
        service.route({ origin: evtPos, destination: evtPos, travelMode: google.maps.DirectionsTravelMode.DRIVING }, function (response, status) {
            if (markers.length > markerLimit) {
                return;
            }
            // Label for ruler marker
            var markerLabel = new overlayLabel(); //Overlay Label for Marker
            markerLabel.span_.style.cssText = 'position: relative; left: -50%; top: -10px;color:white; ' +
                             'white-space: nowrap;font-size:15px;font-weight:600;' +
                             'padding: 2px;text-shadow: 2px 2px 3px rgba(101, 129, 165, 1)';

            markerlength = markers.length + 1;

            var marker = new google.maps.Marker({
                map: map,
                //position: evtPos,
                icon: {
                    path: google.maps.SymbolPath.CIRCLE,
                    scale: 9,
                    strokeColor: "#44B449"
                },
                draggable: true


            });

            marker.segmentIndex = markers.length - 1;

            function updateSegments() {

                markerLabel.bindTo('position', marker, 'position');
                var start, end, inserts, i,
                    idx = this.segmentIndex,
                    segLen = segments.length, //segLen will always be 1 shorter than markers.length
                    myPos = this.getPosition();
                if (idx == -1) { //this is the first marker
                    start = [myPos];
                    end = [markers[1].getPosition()];
                    inserts = [0];
                } else if (idx == segLen - 1) { //this is the last marker
                    start = [markers[markers.length - 2].getPosition()];
                    end = [myPos];
                    inserts = [idx];
                }
                else if (segLen == 2) {

                    start = [markers[idx].getPosition(), myPos];
                    end = [myPos, markers[idx + 1].getPosition()];
                    inserts = [idx, idx + 1];
                } else {
                    start = [markers[idx].getPosition(), myPos];
                    end = [myPos, markers[idx + 2].getPosition()];
                    inserts = [idx, idx + 1];
                }
                for (i = 0; i < start.length; i++) {
                    addSegment(start[i], end[i], inserts[i]);
                }
            }

            for (var i = 0 ; i <= markers.length; i++) {
                if (response.routes[0].legs[0].end_location == undefined) { alert(1); }
                marker.setPosition(response.routes[0].legs[0].end_location);
                markerLabel.bindTo('position', marker, 'position');
                markerLabel.set('text', markerlength);
                markerLabel.setMap(map);

            }
            markerLabels.push(markerLabel);
            markers.push(marker);

            drawPath();

            line.setPath(new getSegmentsPath);
            if (markers.length > 1) {
                addSegment(markers[markers.length - 2].getPosition(), evtPos, marker.segmentIndex);
            }

            google.maps.event.addListener(marker, 'dblclick', function (event) {
                var delSnap = 1;
                deleteRulerMarker(marker, markerLabel, evtPos, delSnap);
                myLabel.setMap(null);

            });
            google.maps.event.addListener(marker, 'drag', updateSegments);
            google.maps.event.addListener(line, 'mouseout', function (e) {
                myLabel.setMap(null);

            });

        });
    });

}

function rulerStraight() {


    //initialize ruler
    line = new google.maps.Polyline({
        map: map,

        strokeColor: "#e65c00",
        strokeOpacity: 3,
        strokeWeight: 2
    });
    //Add Event Listener for Ruler
    google.maps.event.addListener(map, 'click', function (event) {
        var evtPos = event.latLng;
        if (markers.length > markerLimit) {
            return;
        }
        // Label for ruler marker
        var markerLabel = new overlayLabel(); //Overlay Label for Marker
        markerLabel.span_.style.cssText = 'position: relative; left: -50%; top: -10px;color:white; ' +
                         'white-space: nowrap;font-size:15px;font-weight:600;' +
                         'padding: 2px;text-shadow: 2px 2px 3px rgba(101, 129, 165, 1)';

        markerlength = markers.length + 1;
        var marker = new google.maps.Marker({
            map: map,
            //position: evtPos,
            icon: {
                path: google.maps.SymbolPath.CIRCLE,
                scale: 9,
                strokeColor: "#44B449"
            },
            draggable: true


        });

        for (var i = 0 ; i <= markers.length; i++) {

            marker.setPosition(evtPos);
            markerLabel.bindTo('position', marker, 'position');
            markerLabel.set('text', markerlength);
            markerLabel.setMap(map);

        }
        markerLabels.push(markerLabel);
        markers.push(marker);
        var rulStr = true;
        drawPath(rulStr);
        google.maps.event.addListener(marker, 'dblclick', function (event) {
            deleteRulerMarker(marker, markerLabel, evtPos);
            myLabel.setMap(null);

        });
        google.maps.event.addListener(marker, 'drag', function (event) {
            drawPath(rulStr);
            markerLabel.bindTo('position', marker, 'position');

        });
        google.maps.event.addListener(line, 'mouseout', function (e) {
            myLabel.setMap(null);
        });


    });

}




//RULER TO DRAW PATH
function drawPath(rulStr) {

    countMarkers();
    //console.log("count: " + count);
    var coords = [];
    var distances = [];
    var j = 0;

    markerDistanceList = [];

    for (var i = 0; i < markers.length; i++) {


        if (j > 0) {
            j = i - 1;
        }

        coords.push(markers[i].getPosition());
        markerDistance = numberWithCommas(computeDistance(markers[j].getPosition(), markers[i].getPosition()));
        markers[i]['distance'] = markerDistance;
        distances.push(markers[i]['distance']);

        //markerDistanceList.push(markerDistance);
        j = 1;
        //console.log("markerDistance: " + markerDistance);
        var newrm = new rulerMarker(i + 1, markerDistance, markers[i].getPosition().lat().toFixed(4), markers[i].getPosition().lng().toFixed(4), markers[i]);

        markerDistanceList.push(newrm);
        //console.log("marker: " + markerDistanceList[(i)].name + " - " + markerDistanceList[(i)].rulerlength);  

        markerDistanceList.forEach(function (m) {

            google.maps.event.addListener(m.m, 'mouseover', function (e) {
                mousemarker.setPosition(e.latLng);
                myLabel.bindTo('position', mousemarker, 'position');
                myLabel.set('text', "Distance: " + m.rulerlength + " m");
                myLabel.setMap(map);
                console.log(Lines.length);

            });
            google.maps.event.addListener(m.m, 'mouseout', function (e) {
                myLabel.setMap(null);
            });
        });

    }
    if (rulStr) { line.setPath(coords); } else { line.setPath(new getSegmentsPath) }

    meters = google.maps.geometry.spherical.computeLength(coords);

    $('#map-ruler-total').text(numberWithCommas(meters) + ' m');
    //$("distKm").value = Math.round(meters / 1000 * 100) / 100;
    //$("distMi").value = Math.round(meters / 1609 * 100) / 100;
    //console.log("meters: " + meters);
    satvm.RouteList(markerDistanceList);



}

function deleteRulerMarker(marker, markerLabel, evtPos, delSnap) {

    var i = markers.length - 1;
    console.log("length: " + i);
    var rulStr = true;
    if (marker.getPosition() == markers[i].getPosition()) {
        marker.setMap(null);
        drawPath(rulStr);
        if (delSnap) { line.setPath(new getSegmentsPath(delSnap)); }
        markerLabel.setMap(null);
    }
    countMarkers();
}

function countMarkers() {
    count = 0;
    for (var i = markers.length - 1; i >= 0; i--) {
        if (markers[i].getMap() == null) {
            markers.splice(i, 1);
        } else {
            count++;


        }
    }
    return count;
}


function computeDistance(p1, p2) {
    var result = google.maps.geometry.spherical.computeDistanceBetween(p1, p2);
    return result;
};

function getRulerDistance(rulerMarker) {


    if (markerDistanceList[0]) {
        var distance = computeDistance(rulerMarker);

        markerDistanceList.push({});

    }

}


