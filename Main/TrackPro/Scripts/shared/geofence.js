var zoneList = [];
var pointOfInterestList = [];
var routeList = [];


var polygonList = [];
var circleList = [];
var polylineList = [];

var colors =
['#f01515', '#f08415', '#f0dc15', '#e3f015', '#80f015', '#00ff11',
'#15f0b3', '#15eaf0', '#15a8f0', '#3f41e5', '#cba5fb', '#bf00f2', '#000000',
'#ffffff', '#9f9696'];
var colorButtons = {};
var selectedColor;
var selectedOverlay;
var selectedOverlayAreaSize;
var drawingManager;
var geofenceMode;
var overlayComplete = false;
var markerIcon;

function zoneModel(
    _areaInMeters
    , _zoneTypeId
    , _name
    , _parkZone
    , _speedLimitZone
    , _allowedZone
    , _notAllowedZone
    , _timeBased
    , _timeBasedStart
    , _timeBasedEnd
    , _speedLimitInMph
    , _color
    , _enabled
    , _geocoordinateList
    , _geofenceId
) {
    this.areaInMeters = ko.observable(_areaInMeters || 0);
    this.zoneTypeId = _zoneTypeId;
    this.name = ko.observable(_name || 'new zone');
    this.parkZone = ko.observable(_parkZone || false);
    this.speedLimitZone = ko.observable(_speedLimitZone || false);
    this.allowedZone = ko.observable(_allowedZone || false);
    this.notAllowedZone = ko.observable(_notAllowedZone || false);
    this.timeBased = ko.observable(_timeBased || false);
    this.timeBasedStart = "2015-08-09T15:19:01.6864208+08:00";
    this.timeBasedEnd = "2015-08-09T15:19:01.6864208+08:00";
    this.speedLimitInMph = ko.observable(_speedLimitInMph || 0);
    this.color = ko.observable(_color);
    this.enabled = ko.observable(_enabled || true);
    this.geocoordinateList = ko.observableArray(_geocoordinateList);
    this.geofenceId = ko.observable(_geofenceId);
}

function pointOfInterestModel(
    _radiusInMeters
    , _pointOfInterestTypeId
    , _name
    , _parkZone
    , _speedLimitZone
    , _allowedZone
    , _notAllowedZone
    , _timeBased
    , _timeBasedStart
    , _timeBasedEnd
    , _speedLimitInMph
    , _color
    , _enabled
    , _geocoordinateList
    , _geofenceId
) {
    this.radiusInMeters = ko.observable(_radiusInMeters || 0);
    this.pointOfInterestTypeId = _pointOfInterestTypeId;
    this.name = ko.observable(_name || 'new landmark');
    this.parkZone = ko.observable(_parkZone || false);
    this.speedLimitZone = ko.observable(_speedLimitZone || false);
    this.allowedZone = ko.observable(_allowedZone || false);
    this.notAllowedZone = ko.observable(_notAllowedZone || false);
    this.timeBased = ko.observable(_timeBased || false);
    this.timeBasedStart = "2015-08-09T15:19:01.6864208+08:00";
    this.timeBasedEnd = "2015-08-09T15:19:01.6864208+08:00";
    this.speedLimitInMph = ko.observable(_speedLimitInMph || 0);
    this.color = ko.observable(_color);
    this.enabled = ko.observable(_enabled || true);
    this.geocoordinateList = ko.observableArray(_geocoordinateList);
    this.geofenceId = ko.observable(_geofenceId);
}

//function to get bounds of the polygon
google.maps.Polygon.prototype.my_getBounds = function () {
    var bounds = new google.maps.LatLngBounds()
    this.getPath().forEach(function (element, index) { bounds.extend(element) })
    return bounds
}

//function to call the route
function getRoute() {
    $.ajax({
        url: _getRoute,
        type: 'get',
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            ko.mapping.fromJS(rdt, {}, satvm.RouteList);
        },
        error: function (e) {
            if (e != null) {

                createAlert(decryptErrorMessage(e), 'danger');
            }
            else {
                alert('Internal Server Error. Please contact your administrator.');
            }
        }
    });
}

//function to call the zone
function getZoneType() {
    $.ajax({
        url: _getZoneType,
        type: 'get',
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            ko.mapping.fromJS(rdt, {}, satvm.ZoneTypeList);
            getZone();
        },
        error: function (e) {
            if (e != null) {

                createAlert(decryptErrorMessage(e), 'danger');
            }
            else {
                alert('Internal Server Error. Please contact your administrator.');
            }
        }
    });
}

//function create a slider for zone circle radius
function createZoneCircleRadiusSlider(zl) {
    var radius = computeCircleRadius(zl['areaInMeters']);
    $('.zone-circle-slider').slider({
        orientation: "horizontal",
        min: 10,
        max: 25000,
        value: radius,
        step: 10,
        slide: function (event, ui) {
            zl.setOptions({ radius: ui.value });
            satvm.ZoneList().forEach(function (zd) {
                if (zd.geofenceId() == zl['geofenceId']) {
                    zl['areaInMeters'] = computeAreaCircle(radius);
                    zd.areaInMeters(computeAreaCircle(radius));
                }
            });

        }
    });
}

//function to call the zone type list
function getZone() {
    $.ajax({
        url: _getZone,
        type: 'get',
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            ko.mapping.fromJS(rdt, {}, satvm.ZoneList);
            getObjectSettings();
            drawZone();
        },
        error: function (e) {
            if (e != null) {

                createAlert(decryptErrorMessage(e), 'danger');
            }
            else {
                alert('Internal Server Error. Please contact your administrator.');
            }
        }
    });
}

//function to draw the zone
function drawZone() {
    if (satvm.ZoneList().length == 0) {
        console.log('no zones in the list');
        return
    }

    hideOverlayAll('zone');

    //empty the zoneList
    zoneList.length = [];

    var zoneDataList = satvm.ZoneList();

    zoneDataList.forEach(function (zone) {
        var geocoordinateList = zone.geocoordinateList();

        var zoneType = zoneTypeLookUp(zone.zoneTypeId());


        if (geocoordinateList.length == 0) {
            console.log("no geocoordinates.");
            return;
        }

        var newOverlay;
        var overlayLabel;

        if (zoneType == 'Circle') {
            if (geocoordinateList.length > 1) {
                console.log('you are trying to draw a circle with more than geocoordinates!, get hold of yourself');
                return true;
            }
            var computedRadius = computeCircleRadius(zone.areaInMeters());

            newOverlay = new google.maps.Circle({
                strokeColor: zone.color(),
                strokeOpacity: 1,
                strokeWeight: 1,
                clickable: false,
                fillColor: zone.color(),
                fillOpacity: 0.15,
                center: new google.maps.LatLng(
                    geocoordinateList[0].latitude(), geocoordinateList[0].longitude()),
                radius: computedRadius,
                zIndex: 200
            });
            newOverlay['type'] = 'Circle';
            registerCircleEvents(newOverlay);
        }
        else if (zoneType == 'Polygon') {
            var polygonCoordinates = [];
            geocoordinateList.forEach(function (gc) {
                polygonCoordinates.push(new google.maps.LatLng(gc.latitude(), gc.longitude()));
            });

            newOverlay = new google.maps.Polygon({
                strokeColor: zone.color(),
                strokeOpacity: 1,
                strokeWeight: 1,
                paths: polygonCoordinates,
                clickable: false,
                fillColor: zone.color(),
                fillOpacity: 0.15,
                zIndex: 200
            });
            newOverlay['type'] = 'Polygon';
            registerPolygonEvents(newOverlay);
        }
        else {
            return;
        }

        overlayLabel = createGeofenceLabel(newOverlay.getBounds().getCenter(), zone.name(), '#ee8328');
        newOverlay['label'] = new InfoBox(overlayLabel);
        newOverlay['areaInMeters'] = zone.areaInMeters();
        newOverlay['zoneTypeId'] = zone.zoneTypeId();
        newOverlay['geofenceId'] = zone.geofenceId();
        newOverlay['name'] = zone.name();
        newOverlay['allowedZone'] = zone.allowedZone();
        newOverlay['color'] = zone.color();
        newOverlay['enabled'] = zone.enabled();
        newOverlay['label'].open(map);

        zoneList.push(newOverlay);
        newOverlay.setMap(map);
    });
}

//function to lookup 
function zoneTypeLookUp(_zoneTypeId) {
    var zoneTypeName;
    satvm.ZoneTypeList().forEach(function (zt) {
        if (zt.zoneTypeId() == _zoneTypeId) {

            zoneTypeName = zt.name();
        }
    })
    return zoneTypeName;
}

//function to lookup 
function pointOfInterestTypeLookUp(_pointOfInterestTypeId) {
    var pointOfInterestTypeName;
    satvm.PointOfInterestTypeList().forEach(function (pt) {
        if (pt.pointOfInterestTypeId() == _pointOfInterestTypeId) {

            pointOfInterestTypeName = pt.fileName();
        }
    })
    return pointOfInterestTypeName;
}

//function to create Zone
function createZone() {
    if (selectedOverlay) {
        var zoneModelData = satvm.NewZone;
        var zoneType = selectedOverlay['type'];
        if (zoneType == 'Circle') {
            
            zoneModelData().areaInMeters = computeAreaCircle(selectedOverlay.getRadius());

        }

        if (zoneType == 'Polygon') {
            zoneModelData().areaInMeters = computeAreaPolygon(selectedOverlay);

        }

        zoneModelData().color = selectedOverlay.get('strokeColor');

        var gclist = generateCoordinates(selectedOverlay, selectedOverlay['type']);

        zoneModelData().geocoordinateList().length = 0;

        gclist.forEach(function (e) {
            zoneModelData().geocoordinateList().push(e);
        });


        $.ajax({
            url: _createZone,
            type: 'post',
            data: ko.mapping.toJS(zoneModelData),
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, 'info');
                selectedOverlay.setOptions({ visible: false });
                satvm.NewZone(new zoneModel());
                buildColorPaletteNewForm();
                getZone();
                $("#zone-list").click();
            },
            error: function (e) {
                if (e != null) {


                    createAlert(decryptErrorMessage(e), 'danger');
                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }

    $('.zone-content').tabs("option", "active", 0);
}

//function to update selected zone
function updateZone() {
    if (selectedOverlay) {

        var zoneType = selectedOverlay['type'];
        var zoneModelData = satvm.SelectedZone;

        if (zoneType == 'Circle') {
            zoneModelData().areaInMeters = computeAreaCircle(selectedOverlay.getRadius());
        }

        if (zoneType == 'Polygon') {
            zoneModelData().areaInMeters = computeAreaPolygon(selectedOverlay);
        }

        zoneModelData().color = selectedOverlay.get('strokeColor');

        var gclist = generateCoordinates(selectedOverlay, zoneType);
        zoneModelData().geocoordinateList().length = 0;
        gclist.forEach(function (e) {
            zoneModelData().geocoordinateList().push(e);
        });



        $.ajax({
            url: _updateZone,
            type: 'post',
            data: ko.mapping.toJS(zoneModelData),
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, 'info');
                selectedOverlay.setOptions({ visible: false });
                selectedOverlay.label.close();
                satvm.SelectedZone(null);
                handMode();
                getZone();
            },
            error: function (e) {
                if (e != null) {

                    createAlert(decryptErrorMessage(e), 'danger');

                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }
}

//function to delete selected zone
function deleteZone() {
    if (selectedOverlay) {



        $.ajax({
            url: _deleteZone,
            type: 'post',
            data: { '': selectedOverlay['geofenceId'] },
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, "info");
                selectedOverlay.setOptions({ visible: false });
                selectedOverlay['label'].close();
                satvm.SelectedZone(null);
                handMode();
                getZone();
                console.log("alright");
            },
            error: function (e) {
                if (e != null) {

                    createAlert(decryptErrorMessage(e), 'danger');
                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }
}

//function to call the point of interest
function getPointOfInterest() {
    $.ajax({
        url: _getPointOfInterest,
        type: 'get',
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            ko.mapping.fromJS(rdt, {}, satvm.PointOfInterestList);
            drawPointOfInterest();
        },
        error: function (e) {
            if (e != null) {

                createAlert(decryptErrorMessage(e), 'danger');
            }
            else {
                alert('Internal Server Error. Please contact your administrator.');
            }
        }
    });
}

//function to call the point of interest
function getPointOfInterestType() {
    $.ajax({
        url: _getPointOfInterestType,
        type: 'get',
        contentType: 'application/json',
        headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
        success: function (rdt) {
            ko.mapping.fromJS(rdt, {}, satvm.PointOfInterestTypeList);
            getPointOfInterest();
        },
        error: function (e) {
            if (e != null) {
                createAlert(decryptErrorMessage(e), 'danger');
            }
            else {
                alert('Internal Server Error. Please contact your administrator.');
            }
        }
    });
}

//function to create point of interest
function createPointOfInterest() {
    if (selectedOverlay) {
        var poiModelData = satvm.NewPointOfInterest;
        var pointOfInterestType = selectedOverlay['type'];

        poiModelData().radiusInMeters = 100;


        poiModelData().color = '#000';

        var gclist = generateCoordinates(selectedOverlay, 'Marker');

        poiModelData().geocoordinateList().length = 0;

        gclist.forEach(function (e) {
            poiModelData().geocoordinateList().push(e);
        });

        console.log(ko.mapping.toJS(poiModelData));

        //landmark tabs
        //$("#poiList").show();
        //$("#poiNew").hide();

        $('#tabs').tabs("option", "active", 0);



        $.ajax({
            url: _createPointOfInterest,
            type: 'post',
            data: ko.mapping.toJS(poiModelData),
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, 'info');
                selectedOverlay.setOptions({ visible: false });
                satvm.NewPointOfInterest(new pointOfInterestModel());
                getPointOfInterest();
            },
            error: function (e) {
                if (e != null) {

                    createAlert(decryptErrorMessage(e), 'danger');
                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }
}

//function to create point of interest
function updatePointOfInterest() {
    if (selectedOverlay) {
        var poiModelData = satvm.SelectedPointOfInterest;
        var pointOfInterestType = selectedOverlay['type'];

        poiModelData().radiusInMeters = 100;
        poiModelData().color = '#000';

        var gclist = generateCoordinates(selectedOverlay, 'Marker');
        poiModelData().geocoordinateList().length = 0;
        gclist.forEach(function (e) {
            poiModelData().geocoordinateList().push(e);
        });
        console.log(ko.mapping.toJS(poiModelData));

        $.ajax({
            url: _updatePointOfInterest,
            type: 'post',
            data: ko.mapping.toJS(poiModelData),
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, 'info');
                selectedOverlay.setOptions({ visible: false });
                selectedOverlay.label.close();
                satvm.SelectedPointOfInterest(null);
                handMode();
                getPointOfInterest();
            },
            error: function (e) {
                if (e != null) {

                    createAlert(decryptErrorMessage(e), 'danger');
                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }
}

//function to delete selected zone
function deletePointOfInterest() {
    if (selectedOverlay) {

        $.ajax({
            url: _deletePointOfInterest,
            type: 'post',
            data: { '': selectedOverlay['geofenceId'] },
            contentType: 'application/json',
            headers: { 'content-type': 'application/x-www-form-urlencoded', 'accept': 'application/json', 'authorization': 'Bearer ' + token },
            success: function (data) {
                createAlert(data, 'info');
                selectedOverlay.setOptions({ visible: false });
                selectedOverlay['label'].close();
                satvm.SelectedPointOfInterest(null);
                handMode();
                getPointOfInterest();
            },
            error: function (e) {
                if (e != null) {

                    createAlert(decryptErrorMessage(e), 'danger');
                }
                else {
                    alert('Internal Server Error. Please contact your administrator.');
                }
            }
        });
    }
}

//function to draw all point of interest
function drawPointOfInterest() {
    if (satvm.PointOfInterestList().length == 0) {
        console.log('no point of interest in the list');
        return
    }
    hideOverlayAll('poi');
    //empty the zoneList
    pointOfInterestList.length = [];

    var poiDataList = satvm.PointOfInterestList();

    poiDataList.forEach(function (poi) {

        var geocoordinateList = poi.geocoordinateList();

        if (geocoordinateList.length == 0) {
            console.log("no geocoordinates.");
            return;
        }

        var newOverlay;
        var overlayLabel;

        if (geocoordinateList.length > 1) {
            console.log('you are trying to draw a marker with more than geocoordinates!, get hold of yourself');
            return true;
        }

        var pointOfInterestTypeName = pointOfInterestTypeLookUp(poi.pointOfInterestTypeId());


        newOverlay = new google.maps.Marker({
            clickable: true,
            icon: '../Content/images/marker/' + pointOfInterestTypeName + '.png',
            position: new google.maps.LatLng(
                geocoordinateList[0].latitude(), geocoordinateList[0].longitude())
        });

        registerMarkerEvents(newOverlay);

        newOverlay['type'] = 'Marker';
        overlayLabel = createGeofenceLabel(newOverlay.getPosition(), poi.name(), '#49ac0d');
        newOverlay['label'] = new InfoBox(overlayLabel);
        newOverlay['radiusInMeters'] = poi.radiusInMeters();
        newOverlay['pointOfInterestTypeId'] = poi.pointOfInterestTypeId();
        newOverlay['geofenceId'] = poi.geofenceId();
        newOverlay['name'] = poi.name();
        newOverlay['allowedZone'] = poi.allowedZone();
        newOverlay['color'] = poi.color();
        newOverlay['enabled'] = poi.enabled();
        newOverlay['label'].open(map);

        pointOfInterestList.push(newOverlay);
        newOverlay.setMap(map);
    });
}

//function to create polygon
function createPolygon(data) {

}

//function to create polygon
function createCircle(data) {

}

//function to create polygon
function createPolyline(clist, lineSymbol) {

    polyLine = new google.maps.Polyline({
        path: clist,
        icons: [{
            icon: lineSymbol,
            offset: '100%'
        }],
        geodesic: true,
        strokeColor: '#000',
        strokeOpacity: 1.0,
        strokeWeight: 2
    });
    return polyLine;
}

///
///Accessory Functions
///

//function to compute area google polygon
function computeAreaPolygon(path) {
    return google.maps.geometry.spherical.computeArea(path);
}

//function to compute area google circle
function computeAreaCircle(radius) {
    return (radius * radius) * Math.PI;
}

//function to compute area google circle
function computeCircleRadius(area) {
    return Math.sqrt(area / Math.PI);
}

//function to set drawing mode to hand
function handMode() {
    drawingManager.setDrawingMode(null);

    //clear zone form
    // satvm.NewZone(new zoneModel({}));
}

//function to set drawing mode to polygon
function polygonMode(_geofenceMode) {
    geofenceMode = _geofenceMode;
    drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON)
}

//function to set drawing mode to polyline
function polylineMode() {
    drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYLINE)
}

//function to set drawing mode to circle
function circleMode(_geofenceMode) {
    geofenceMode = _geofenceMode;
    drawingManager.setDrawingMode(google.maps.drawing.OverlayType.CIRCLE)
}

//function to set drawing mode to marker
function markerMode(_geofenceMode, icon) {
    _markerOptions = { icon: '../Content/images/marker/' + icon + '.png' };
    geofenceMode = _geofenceMode;
    drawingManager.setDrawingMode(google.maps.drawing.OverlayType.MARKER)
}


//function to clear selected shape
function clearOverlaySelection() {
    if (selectedOverlay) {
        selectedOverlay.setOptions({ editable: false, draggable: false });
        selectedOverlay = null;
    }
}

//function to enable editing on selected overlay
function overlayEditMode(overlay) {
    clearOverlayAll();
    overlay.setOptions({ draggable: true, editable: true, clickable: true });
}

//function to clear off of editing mode all the overlays
function clearOverlayAll() {
    zoneList.forEach(function (zl) {
        zl.setOptions({ editable: false, draggable: false, clickable: false });
    })
}

//function to clear off of editing mode all the overlays
function hideOverlayAll(type) {
    switch (type) {
        case 'poi':
            pointOfInterestList.forEach(function (poi) {
                poi.setOptions({ visible: false });
            });
            break;
        case 'zone':
            zoneList.forEach(function (zl) {
                zl.setOptions({ visible: false });
            })
            break;
        default:
            break;
    }
}

//function to make color button
function makeColorButton(color) {
    var button = document.createElement('span');
    button.className = 'color-button';
    button.style.backgroundColor = color;
    google.maps.event.addDomListener(button, 'click', function () {
        selectColor(color);
        setSelectedOverlayColor(color);
    });
    return button;
}

//function to hide the current overlay
function hideOverlay(_selectedOverlay) {
    if (_selectedOverlay) {
        _selectedOverlay.setOptions({ visible: false });
    }
}

//function to set selected overlay
function setSelectedOverlayColor(color) {
    if (selectedOverlay) {
        selectedOverlay.setOptions({ fillColor: color, strokeColor: color });
    }
}

//function to set color of the drawing manager
function selectColor(color) {
    selectedColor = color;
    //for (var i = 0; i < colors.length; ++i) {
    //    var currColor = colors[i];
    //    colorButtons[currColor].style.border = currColor == color ? '2px solid #789' : '2px solid #fff';
    //}

    var polygonOptions = drawingManager.get('polygonOptions');
    polygonOptions.fillColor = color;
    polygonOptions.strokeColor = color;

    var circleOptions = drawingManager.get('circleOptions');
    circleOptions.fillColor = color;
    circleOptions.strokeColor = color;

    var polylineOptions = drawingManager.get('polylineOptions');
    polylineOptions.fillColor = color;
    polylineOptions.strokeColor = color;

    drawingManager.set('circleOptions', circleOptions);
    drawingManager.set('polygonOptions', polygonOptions);
    drawingManager.set('polylineOptions', polylineOptions);
}

//function to build the color pallete
function buildColorPaletteEditForm() {
    var colorPalette = $('#color-palette-edit-form');
    colorPalette.empty();
    if (colorPalette.children().length < 1) {
        for (var i = 0; i < colors.length; ++i) {
            var currColor = colors[i];
            var colorButton = makeColorButton(currColor);
            colorPalette.append(colorButton);
            colorButtons[currColor] = colorButton;
        }
        selectColor(colors[0]);
    }
}

//function to build the color pallete
function buildColorPaletteNewForm() {
    //alert('color palette');
    var colorPalette = $('#color-palette-new-form');
    colorPalette.empty();
    if (colorPalette.children().length < 1) {
        for (var i = 0; i < colors.length; ++i) {
            var currColor = colors[i];
            var colorButton = makeColorButton(currColor);
            colorPalette.append(colorButton);
            colorButtons[currColor] = colorButton;
        }
        selectColor(colors[0]);
    }
}

//function to get coordinates collection using polygon overlay data
function generateCoordinates(newOverlay, type) {
    var latlngcoll = [];
    switch (type) {
        case 'Marker':
            var position = newOverlay.getPosition();
            latlngcoll.push({ "Longitude": position.lng(), "Latitude": position.lat() });
            break;
        case 'Polygon':
            var shapeLength = newOverlay.getPath().getLength();
            for (var i = 0; i < shapeLength  ; i++) {
                if (newOverlay.visible == true) {
                    var latlng = newOverlay.getPath().getAt(i).toUrlValue(5);
                    var res = latlng.split(",");
                    latlngcoll.push({ "Longitude": res[1], "Latitude": res[0] });
                }
            }
            break;
        case 'Circle':
            var center = newOverlay.getCenter();
            latlngcoll.push({ "Longitude": center.lng(), "Latitude": center.lat() });
            break;
        default:
    }
    return latlngcoll;
}

function createGeofenceLabel(position, name, color) {
    var labelOptions = {
        content: name,
        boxStyle: {
            textAlign: "center",
            fontSize: "10px",
            whiteSpace: "nowrap",
            background: color,
            borderRadius: "15px",
            opacity: 0.8,
            padding: "5px 7px 5px 7px",
            color: "#fff",
            zIndex: 4
        },
        disableAutoPan: false,
        pixelOffset: new google.maps.Size(0, 0),
        position: position,
        closeBoxURL: "",
        isHidden: false,
        pane: "floatPane",
        enableEventPropagation: true
    };
    return labelOptions;
}

//function to register to polygon events
function registerPolygonEvents(newOverlay) {

    google.maps.event.addListener(newOverlay, 'dragend', function () {

        this['label'] = new InfoBox(createGeofenceLabel(newOverlay.getBounds().getCenter(), this.name, '#ee8328'));
        this['label'].open(map);
    });

    google.maps.event.addListener(newOverlay, 'dragstart', function () {
        this.label.close();
    });
}

//function to register to circle events
function registerCircleEvents(newOverlay) {
    google.maps.event.addListener(newOverlay, 'radius_changed', function () {
        var circleRadius = newOverlay.getRadius();
        var circleArea = computeAreaCircle(circleRadius);
        $('.radius-label').text(numberWithCommas(circleRadius) + ' meters');
        console.log(circleRadius);
    });

    google.maps.event.addListener(newOverlay, 'dragstart', function () {
        this.label.close();
    });

    google.maps.event.addListener(newOverlay, 'dragend', function () {
        this['label'] = new InfoBox(createGeofenceLabel(newOverlay.getBounds().getCenter(), this.name, '#ee8328'));
        this['label'].open(map);
    });
}

//function to register to amrker events
function registerMarkerEvents(newOverlay) {
    google.maps.event.addListener(newOverlay, 'dragstart', function () {
        this.label.close();
    });

    google.maps.event.addListener(newOverlay, 'dragend', function () {
        this['label'] = new InfoBox(createGeofenceLabel(newOverlay.getPosition(), this.name, '#49ac0d'));
        this['label'].open(map);
    });
}

//function to hide the map tools
function hideMapTools() {
    satvm.SelectedZone(null);
    satvm.SelectedPointOfInterest(null);
}

//extension to create a function on getting the bounds
google.maps.Polygon.prototype.getBounds = function () {
    var bounds = new google.maps.LatLngBounds();
    var paths = this.getPaths();
    var path;
    for (var i = 0; i < paths.getLength() ; i++) {
        path = paths.getAt(i);
        for (var ii = 0; ii < path.getLength() ; ii++) {
            bounds.extend(path.getAt(ii));
        }
    }
    return bounds;
}