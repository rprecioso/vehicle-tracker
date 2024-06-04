//Title: Top 10 Closest Objects
//Description: Get top 10 closest objects from a certain point with their corresponding distance
//Required Libraries: googleapis-geometry
//Last Update: 2015-07-30
var eventLatLng;

function nearestAssetModeOn() {
    $('#cbx_overlay_interval').prop('checked',false);
    stopAssetInterval();
    functionOn('nearestAsset');
    google.maps.event.clearListeners(map, 'click');
    google.maps.event.addListener(map, 'click', function (event) {
        if (markerClosest) {
            markerClosest.setMap(null);
            polyLineList.forEach(function (m) {
                m.setMap(null);
            });
            polyLineList.length = 0;
        }
        //console.log(event.latLng);
        eventLatLng = event.latLng;
        getClosestObjects(event.latLng);
    });
}

function nearestAssetModeOff() {
    if (markerClosest) {
        google.maps.event.clearListeners(map, 'click');
        markerClosest.setMap(null);
    }
    //objectMarkers.forEach(function (o) {
    //   // if (o.objectid == m.objectId) {
    //        o.setOptions({ visible: false });
    //   // }
    //});

    satvm.NearbyObjects([]);
    $('.nearby-asset-btn').text("Search");
    polyLineList.forEach(function (p) {
        p.setOptions({ visible: false });
    });
}

function convertToPoint(lat, lng) {
    return new google.maps.LatLng(lat, lng);
};

function computeDistance(p1, p2) {
    var result = google.maps.geometry.spherical.computeDistanceBetween(p1, p2);
    return result;
};


function nearbyObject(objectName, objectId, distance, coordinates, latitude, longitude) {
    this.objectName = objectName;
    this.objectId = objectId;
    this.distance = +distance.toFixed(2);
    this.coordinates = coordinates;
    this.latitude = latitude;
    this.longitude = longitude;
}

var nearbyLine;

function createPolylineNearby(clist) {
    nearbyLine = new google.maps.Polyline({
        path: clist,
        geodesic: true,
        strokeColor: '#2378A3',
        strokeOpacity: 0.65,
        strokeWeight: 3
    });
    return nearbyLine;
}


function getClosestObjects(point) {

    satvm.NearbyObjects.removeAll();


    var marker = new google.maps.Marker({
        icon: '../Content/images/marker/nearest_asset_marker.png',
        position: point,
        map: map,
        draggable: true
    });

    //create invisible marker
    var mousemarker = new google.maps.Marker({
        position: point,
        map: map,
        visible: false,
    });

    
    google.maps.event.addListener(marker, 'dragend', function (event) {

        if (markerClosest) {
            markerClosest.setMap(null);

            polyLineList.forEach(function (m) {
                m.setMap(null);
            });
            polyLineList.length = 0;

        }
        getClosestObjects(event.latLng);
    });

    markerClosest = marker;

    var objDistanceList = [];

    var count = 0;

    objectMarkers.forEach(function (m) {
        var distance = computeDistance(m.getPosition(), point);
        objDistanceList.push(
            new nearbyObject(m['objectname'], m['objectid'], distance, m.getPosition(), m.getPosition().lat().toFixed(4), m.getPosition().lng().toFixed(4))
            );
    });

    objDistanceList.sort(
        function (a, b) {
            return (a.distance - b.distance);
        });



    objDistanceList.forEach(function (m) {
        count += 1;

        if (count < 11 && m.distance <= satvm.NearbyDistanceLimit()) {
            //objectMarkers.forEach(function (o) {
            //    console.log("o: " + o.objectid + " m:" + m.objectId);
            //    if (o.objectid == m.objectId) {
            //        o.setOptions({ visible: true });
            //    }
            //});


            var clist = [];
            clist.push(point);
            clist.push(m.coordinates);

            var t = createPolylineNearby(clist);
            t.setMap(map);
            polyLineList.push(t);

            m.distance = numberWithCommas(m.distance);
            var nearbyLabel = new overlayLabel(); // Label for Nearby hover

            nearbyLabel.span_.style.cssText = 'position: relative; left: -50%; top: -50px;color:#000000; ' +
            'white-space: nowrap;font-size:16px;font-weight:600;' +
            'padding: 2px;text-shadow: 3px 0px 2px rgba(101, 129, 165, 1);';
            var lineSymbol = {
                path: 'M 0,-1 0,1',
                strokeOpacity: 0.9,
                scale: 2
            };
            function animateLine(t) {
                var count = 0;
                window.setInterval(function () {
                    count = (count + 1) % 200;

                    var icons = t.get('icons');
                    icons[0].offset = (count / 2) + '%';
                    t.set('icons', icons);

                }, 20);
            }
            google.maps.event.addListener(t, 'mouseover', function (e) {
                console.log(m.distance);
                animateLine(t);
                this.setOptions({
                    icons: [{
                        icon: lineSymbol,
                        offset: '0',
                        repeat: '10px'
                    }],
                    strokeColor: "#2378A3",
                    strokeOpacity: 0,
                    zIndex: 9999,
                });
                mousemarker.setPosition(e.latLng);
                nearbyLabel.bindTo('position', mousemarker, 'position');
                nearbyLabel.set('text', "Distance: " + m.distance + " m");
                nearbyLabel.setMap(map);
            });

            google.maps.event.addListener(t, 'mouseout', function (e) {

                this.setOptions({
                    icons: [{
                        offset: '0%'
                    }],
                    strokeColor: "#2378A3",
                    strokeOpacity: 0.5,
                    strokeWeight: 3,
                });

                nearbyLabel.setMap(null);

            })

            satvm.NearbyObjects.push(m);
        }

    });


};


var polyLineList = [];
$('.nearby-asset-btn').text("Search");
$('.nearby-asset-btn').click(function () {
    if (gpsInfoReady == true) {
        var o = this;
        var text = $(this).text();
        if (text == "Clear") {
            nearestAssetModeOff();
            $('.nearest-asset-panel').children().first().next().hide();
        } else {
            createAlert('Click on the map to place pin. Drag and drop the pin or click on the map to search again', 'info');
            nearestAssetModeOn();
            $(this).text("Clear");
        }
    }
    else {
        createAlert('Asset data is not loaded yet.', 'warning');
    }
});

