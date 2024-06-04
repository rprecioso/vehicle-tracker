//variables
var map;
var assetInterval = null;
var historyInterval = null;
var historyDotMarkers = [];
var historyMarker;
var gpsInfoReady = false;
var markerClosest;
var closestDistance;
var objectMarkers = [];
var token = localStorage.getItem('access_token');
var username = localStorage.getItem('username');
var baseUrl = localStorage.getItem('serverUrl');
var serverCode = localStorage.getItem('serverCode');
var ws = 'ws';
if (serverCode === "local") {
    ws = '';
}
var lineSymbol;
var historyLine;

var currentFunctionStatus;

function functionStatus(_functionName, _value) {
    this.functionName = _functionName;
    this.value = _value;
}

var _getObjectBasic = baseUrl + 'Track' + ws + '/Object/Get/List';
var _getAllObjectGPSInfo = baseUrl + 'Track' + ws + '/GPSInfo/Get/List';
var _getHistoryObjectGPSInfo = baseUrl + 'Track' + ws + '/GPSInfo/Get/History';
var _getObjectSettings = baseUrl + 'api/Sensepro/SensorInfo/Get/List';
var _updateObjectSettings = baseUrl + 'Track' + ws + '/Asset/Update/Info';
var _updateUserSettings = baseUrl + 'Account/Update/Password/' + ws;
var _getAssetGPSInfo = baseUrl + 'Track' + ws + '/GPSInfo/Get';

//geofence
//route
var _getRoute = baseUrl + 'Geofence/Route/List';
var _updateRoute = baseUrl + 'Geofence/Route/Update';
var _createRoute = baseUrl + 'Geofence/Route/Create';
var _deleteRoute = baseUrl + 'Geofence/Route/Delete';

//zone
var _getZoneType = baseUrl + 'Geofence/Zone/Type/List';
var _getZone = baseUrl + 'Geofence/Zone/List';
var _updateZone = baseUrl + 'Geofence/Zone/Update';
var _createZone = baseUrl + 'Geofence/Zone/Create';
var _deleteZone = baseUrl + 'Geofence/Zone/Delete';

//POI
var _getPointOfInterestType = baseUrl + 'Geofence/PointOfInterest/Type/List';
var _getPointOfInterest = baseUrl + 'Geofence/PointOfInterest/List';
var _updatePointOfInterest = baseUrl + 'Geofence/PointOfInterest/Update';
var _createPointOfInterest = baseUrl + 'Geofence/PointOfInterest/Create';
var _deletePointOfInterest = baseUrl + 'Geofence/PointOfInterest/Delete';

//weather
var _getMarineWeatherData = baseUrl + 'Weather/Marine/Get';


//function to get current date time in yyyy/mm/dd hh:mm:ss format
function getDateTime() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var day = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    if (month.toString().length == 1) {
        var month = '0' + month;
    }
    if (day.toString().length == 1) {
        var day = '0' + day;
    }
    if (hour.toString().length == 1) {
        var hour = '0' + hour;
    }
    if (minute.toString().length == 1) {
        var minute = '0' + minute;
    }
    if (second.toString().length == 1) {
        var second = '0' + second;
    }
    var dateTime = year + '/' + month + '/' + day + ' ' + hour + ':' + minute + ':' + second;
    return dateTime;
}

function getDateTimeNs() {
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth() + 1;
    var day = now.getDate();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    if (month.toString().length == 1) {
        var month = '0' + month;
    }
    if (day.toString().length == 1) {
        var day = '0' + day;
    }
    if (hour.toString().length == 1) {
        var hour = '0' + hour;
    }
    if (minute.toString().length == 1) {
        var minute = '0' + minute;
    }
    if (second.toString().length == 1) {
        var second = '0' + second;
    }
    var dateTime = year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
    return dateTime;
}

//function to logout
function logout() {
    localStorage.clear();
    location.href = '../Login';
}

function gotoreportpro() {

    window.location.href = "http://beta.philgps.com/trackreport";

}


function assetModel(obj) {
    //latitude, longitude, course, objectId, objectName

    try {
     
        this.latitude = obj.latitude();
        this.longitude = obj.longitude();
        this.course = obj.course();
        this.objectId = obj.objectId();
        this.objectName = obj.objectName();
        this.location = obj.location();
        this.speed = obj.speed();
        this.gpsTime = obj.gpsTime();
        this.serverTime = obj.serverTime();
        this.course = obj.course();
        this.geofence = obj.geofence();
        this.geofenceOverspeed = obj.geofenceOverspeed();
        this.status = obj.status();
        this.fuel = obj.fuel();
        this.temperature1 = obj.temperature1();
        this.temperature2 = obj.temperature2();
        this.sim = obj.sim();
        this.odometer = obj.odometer();
        this.fuelRatio = obj.fuelRatio();
        this.fuelType = obj.fuelType();
        this.photoUrl = obj.photoUrl();
    } catch (e) {     


        this.latitude = obj.latitude;
        this.longitude = obj.longitude;
        this.course = obj.course;
        this.objectId = obj.objectId;
        this.objectName = obj.objectName;
        this.location = obj.location;
        this.speed = obj.speed;
        this.gpsTime = obj.gpsTime;
        this.servertime = obj.serverTime;
        this.course = obj.course;
        this.geofence = obj.geofence;
        this.geofenceoverspeed = obj.geofenceOverspeed;
        this.status = obj.status;
        this.fuel = obj.fuel;
        this.temperature1 = obj.temperature1;
        this.temperature2 = obj.temperature2;
        this.sim = obj.sim;
        this.odometer = obj.odometer;
        this.fuelratio = obj.fuelRatio;
        this.fueltype = obj.fuelType;
        this.photoUrl = obj.photoUrl;
    }

}

function updateObjectMarker(res, objectMarker) {

    objectMarker['objectid'] = res.objectId;
    objectMarker['objectname'] = res.objectName;
    objectMarker['latitude'] = res.latitude;
    objectMarker['longitude'] = res.longitude;
    objectMarker['location'] = res.location;
    objectMarker['speed'] = res.speed;
    objectMarker['gpstime'] = res.gpsTime;
    objectMarker['boardtime'] = res.serverTime;
    objectMarker['direction'] = res.course;
}

//function to look up/search the objectmarker from objectmarkers array
function objectMarkersLookup(objectid) {
    if (objectMarkers.length > 0) {
        var queryObjectMarker = Enumerable.From(objectMarkers)
        .Where(function (x) { return x['objectid'] == objectid })
        .ToArray();
        if (queryObjectMarker[0]) {
            return queryObjectMarker[0];
        }
    }
    return null;
}

//function to get the image marker icon based on course
function objectMarkerIconCourse(deg, type) {
    var direction;

    if (deg <= 22.5) {
        direction = 'N';
    } else if (deg <= 67.5) {
        direction = 'NE';
    } else if (deg <= 112.5) {
        direction = 'E';
    } else if (deg <= 157.5) {
        direction = 'SE';
    } else if (deg <= 202.5) {
        direction = 'S';
    } else if (deg <= 247.5) {
        direction = 'SW';
    } else if (deg <= 292.5) {
        direction = 'W';
    } else if (deg <= 337.5) {
        direction = 'NW';
    } else {
        direction = 'N';
    }

    switch (type) {
        case 'cargo':
            //return '../Content/images/marker/ship_animated.gif';
            return '../Content/images/cargo/Cargo_' + direction + '_xs.png';
            break;
        case 'car':
            return '../Content/images/car/car_' + direction + '_xs.png';
        case 'truck':
            return '../Content/images/truck_top/3DTruck_smoke_' + direction + '.gif';
            break;
        default:
    }
}
//function to get the image marker icon based on course
function getDirectionCourse(deg) {
    var direction;
    var deg = deg;

    if (deg <= 22.5) {
        direction = 'N';
    } else if (deg <= 67.5) {
        direction = 'NE';
    } else if (deg <= 112.5) {
        direction = 'E';
    } else if (deg <= 157.5) {
        direction = 'SE';
    } else if (deg <= 202.5) {
        direction = 'S';
    } else if (deg <= 247.5) {
        direction = 'SW';
    } else if (deg <= 292.5) {
        direction = 'W';
    } else if (deg <= 337.5) {
        direction = 'NW';
    } else {
        direction = 'N';
    }


    return direction;

}

//Account Model
function accountModel(_currentPassword, _newPassword, _confirmPassword) {
    this.newPassword = _newPassword,
    this.confirmPassword = _confirmPassword,
    this.currentPassword = _currentPassword
}

//function to read mdtstatus
function ReadMDTStatus(amustatus) {
    var result;

    if (amustatus[0] >> 2 & parseInt(01, 16) === parseInt(1, 10)) {
        result = 'ACC Off';
    }
    else {
        result = 'Acc On';
    }

    if (amustatus[11] >> 1 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Sensor 2 On'
    }

    if (amustatus[1] >> 3 & (parseInt(01, 16) === parseInt(1, 10))) {
        result = result + ',Battery Cut'
    }

    if (amustatus[2] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Out of line'
    }

    if (amustatus[3] >> 1 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Over Speed'
    }

    if (amustatus[6] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Over Idle'
    }

    if (amustatus[5] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Geofence Exit'
    }

    if (amustatus[5] >> 2 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Geofence Entry'
    }

    if (amustatus[4] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Battery Low'
    }

    if (amustatus[2] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',GPS Cut'
    }

    if (amustatus[3] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Engine Stop'
    }

    if (amustatus[1] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',SOS'
    }

    if (amustatus[11] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Sensor 1 On'
    }

    return result;
}


function changeElementByMDTstatus(element, mdtstatus) {
    var result;

    if (amustatus[0] >> 2 & parseInt(01, 16) === parseInt(1, 10)) {
        result = 'ACC Off';
    }
    else {
        result = 'Acc On';
    }

    if (amustatus[11] >> 1 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Sensor 2 On'
    }

    if (amustatus[1] >> 3 & (parseInt(01, 16) === parseInt(1, 10))) {
        result = result + ',Battery Cut'
    }

    if (amustatus[2] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Out of line'
    }

    if (amustatus[3] >> 1 & parseInt(01, 16) === parseInt(1, 10)) {
        result = "#66ff66"; //Over Speed, Light Green
    }

    if (amustatus[6] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Over Idle'
    }

    if (amustatus[5] >> 3 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Geofence Exit'
    }

    if (amustatus[5] >> 2 & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Geofence Entry'
    }

    if (amustatus[4] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Battery Low'
    }

    if (amustatus[2] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',GPS Cut'
    }

    if (amustatus[3] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Engine Stop'
    }

    if (amustatus[1] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',SOS'
    }

    if (amustatus[11] & parseInt(01, 16) === parseInt(1, 10)) {
        result = result + ',Sensor 1 On'
    }

    $(element).css({ "color": result });
    //return result;

    //var statusTypes =
    //        ['battery cut'
    //        , 'gps cut'
    //        , 'sensor 1 on'
    //        , 'sensor 2 on'
    //        , 'over speed'
    //        , 'over idle'
    //        , 'sos'
    //        , 'battery low']


    //switch (status) {
    //    case 'ACC On':
    //        break;
    //    case 'ACC Off':
    //        break;
    //    case 'ACC Off,Battery Cut':
    //        break;
    //    case 'ACC On,Battery Cut':
    //        break;
    //    case 'ACC Off,Battery Cut,Battery Low':
    //        break;
    //    case 'ACC On,Battery Cut,Battery Low':
    //        break;
    //    case 'ACC Off,Battery Low':
    //        break;
    //    case 'ACC On,Battery Low':
    //        break;
    //    case 'ACC Off,SOS':
    //        break;
    //    case 'ACC On,SOS':
    //        break;
    //    case 'ACC On,Over Speed':
    //        break;
    //    case 'ACC Off,Over Speed':
    //        break;
    //    case 'ACC On,Sensor 2 On,Sensor 1 On':
    //        break;
    //    case 'ACC Off,Sensor 2 On,Sensor 1 On':
    //        break;
    //    case 'ACC On,Sensor 1 On':
    //        break;
    //    case 'ACC Off,Sensor 1 On':
    //        break;
    //    case 'ACC On,Sensor 2 On':
    //        break;
    //    case 'ACC Off,Sensor 2 On':
    //        break;
    //    case 'ACC Off,Battery Cut,Over Idle':
    //        break;
    //    case 'ACC On,Battery Cut,Over Idle':
    //        break;
    //    case 'ACC Off,Over Idle':
    //        break;
    //    case 'ACC On,Over Idle':
    //        break;
    //    case 'ACC On,Battery Low,Over Idle':
    //        break;
    //    case 'ACC Off,Battery Low,Over Idle':
    //        break;
    //    case 'ACC On,GPS Cut':
    //        break;
    //    case 'ACC Off,GPS Cut':
    //        break;
    //    case 'ACC On,Over Speed,Sensor 1 On':
    //        break;
    //    case 'ACC Off,Over Speed,Sensor 1 On':
    //        break;
    //    case 'ACC Off,Over Speed,Sensor 2 On':
    //        break;
    //    case 'ACC On,Over Speed,Sensor 2 On':
    //        break;
    //    case 'ACC On,SOS':
    //        break;
    //    case 'ACC On,SOS':
    //        break;
    //    case 'ACC On,SOS':
    //        break;
    //    case 'ACC On,SOS':
    //        break;
    //    default:

    //}

}

//function to change the color of the element
function changeElementColorByStatus(element, status) {
    var color = "#000000";
    switch (status) {
        case 'driving':
            color = "#006600";
            break;
        case 'idling':
            color = "#66ff66";
            break;
        case 'gps cut':
            color = "#ffcc00";
            break;
        case 'battery cut':
            color = "#ffcc00";
            break;
        case 'sos':
            color = "#ff0000";
            break;
        case 'parking':
            color = "#003399";
            break;
        case 'overidling':
            color = "#ff0000";
            break;
        default:
            break;
    }
    $(element).css({ "color": color });
}

function getColorStatus(status) {
    var result = {};


    switch (status) {
        case 'active':
            ////black
            result.status = 'Active';
            result.color = '#000000';
            break;
        case 'overidling':
            ////red
            result.color = "#ff0000";
            result.status = 'Over Idling';
            break;

        case 'overspeeding':
            ////red
            result.color = "#ff0000";
            result.status = 'Over Speeding';
            break;

        case 'parking':
            ////blue
            result.color = '#003399';
            result.status = 'Parking';
            break;

        case 'sos':
            //red
            result.color = "#ff0000";
            result.status = 'SOS';
            break;

        case 'batteryCut':
            //yellow
            result.color = "#ffcc00";
            result.status = 'Battery Cut';
            break;

        case 'gpsCut':
            //yellow
            result.color = "#ffcc00";
            result.status = 'GPS Cut';
            break;

        case 'driving':
            //green
            result.color = "#006600";
            result.status = 'Driving ';
            break;

        case 'idling':
            //light green
            result.color = "#66ff66";
            result.status = 'Idling';
            break;

        case 'batteryLow':
            //yellow
            result.color = "#ffcc00";
            result.status = 'GPS Cut';

            break;
        case 'inactive':
            //white
            result.status = 'Inactive';
            result.color = '#888888';
            break;
        default:
            //transparent
            result.status = 'n/a';
            result.color = 'transparent';
            break;
    }
    return result;
}

function getAssetStatus(speed, status, gpstime,callee) {
    console.log('getAssetStatus/status: ' + status);
    console.log('getAssetStatus/speed: ' + speed);
    //console.log(callee);
    var result = getColorStatus('inactive');

    var statOn = status.indexOf('ACC On') != -1;
    var statOff = status.indexOf('ACC Off') != -1;
    var sos = status.indexOf('SOS') != -1;
    var batteryCut = status.indexOf('Battery Cut') != -1;
    var batteryLow= status.indexOf('Battery Low') != -1;
    var gpsCut = status.indexOf('GPS Cut') != -1;
    var overidle = status.indexOf('Over Idle') != -1;

    var objDateString = gpstime.toString();
    var objDate = objDateString.slice(0, 10);
    var objTime = objDateString.slice(11, 19);
    var objDateFormated = new Date(objDate + "T" + objTime);
    var objDateMinus = new Date();
    var today = new Date(Date.now());
    objDateMinus.setDate(today.getDate() - 1);


    if (objDateFormated > objDateMinus) {
        result = getColorStatus('active');

        //Overidling
        if (speed === 0 && statOn === true && overidle == true) {
           result =  getColorStatus('overidling');
        }

        //Parking
        if (statOff == true) {
            result = getColorStatus('parking');
        }

        //SOS
        if (sos == true) {
            result = getColorStatus('sos');
        }

        //Battery Cut
        if (batteryCut == true) {
            result = getColorStatus('batteryCut');
        }

        //GPS Cut
        if (gpsCut == true) {
            result = getColorStatus('gpsCut');
        }

        //Driving
        if (statOn == true && speed > 0) {
            result = getColorStatus('driving');
        }

        //Idling
        if (statOn == true && speed === 0) {
            result = getColorStatus('idling');
        }

    }

    return result;

}




//function to convert lon lat to dms
function convertDecimalToDMS(lat, lng) {

    //S - Negative Lat
    //N - Positive Lat

    //W - Negative Lon
    //E - Positive Lon

    var LatCardinal = ((lat > 0) ? 'N' : 'S');
    var LngCardinal = ((lng > 0) ? 'E' : 'W');

    //get abs
    var LatAbs = Math.abs(lat);
    var LngAbs = Math.abs(lng);

    //get degrees
    var LatDeg = Math.floor(LatAbs);
    var LngDeg = Math.floor(LngAbs);

    //get fractions
    var LatFrc = LatAbs - LatDeg;
    var LngFrc = LngAbs - LngDeg;

    //get seconds
    var LatSec = LatFrc * 3600;
    var LngSec = LngFrc * 3600;

    //get minutes
    var LatMin = Math.floor(LatSec / 60);
    var LngMin = Math.floor(LngSec / 60);

    LatSec = Math.floor(LatSec - (LatMin * 60));
    LngSec = Math.floor(LngSec - (LngMin * 60));


    return LatDeg + '° ' + LatMin + '\' ' + LatSec + '\'\' ' + LatCardinal + ' ' + LngDeg + '° ' + LngMin + '\' ' + LngSec + '\'\' ' + LngCardinal;
}

//function to convert mph to knots
function kphToKnots(kph) {
    return kph * 0.5399568;
}

//function to convert meters to nautical miles
function mToNmi(m) {
    return m * 0.00053996;
}

//function to add commas
function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts[0];//.join(".");
}

//function to add commas
function numberWithCommas2(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}

//function to create alert
createAlert = function (message, type) {

    $('#alert_placeholder').show('slide');
    $('#alert_placeholder').html('<div class="alert alert-' + type + ' alert-dismissable alert-custom"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button><span>' + message + '</span></div>')
    setTimeout(function () {
        $('#alert_placeholder').hide('slide');
    }, 10000);

};


//function animateCircle(line) {
//    var count = 0;
//    historyInterval = window.setInterval(function () {
//        count = (count + 1) % 200;
//        var icons = line.get('icons');
//        icons[0].offset = (count / 2) + '%';
//        line.set('icons', icons);
//    }, polylineList.length);
//}

//function animateCircle(line, animCount, polLen) {
//    //alert(animCounts);
//    console.log(isPaused);

//    var polLen2 = polLen / 100;
//    console.log("polLen2: " + polLen2);
//    timerInterval = window.setInterval(function () {
//        if (!isPaused) {
//            //console.log("count1: " + animCount);
//            var count2 = animCounts[animCounts.length - 1];
//            //console.log("animcounts: " + count2);
//            // if (count2 != null) {
//            animCount = (count2 + 1) % (polLen + 1);
//            animCounts.push(animCount);
//            //}
//            var icons = line.get('icons');
//            icons[0].offset = (animCount / polLen2) + '%';
//            line.set('icons', icons);
//           // console.log('offset: ' + icons[0].offset);
//        }
//    }, 100);
//}

var historyAnimationInterval;
function animateHistoryIcon(line) {
    var count = 0;
    historyAnimationInterval = setInterval(function () {
        count = (count + 1) % 200;

        var icons = line.get('icons');
        icons[0].offset = (count / 2) + '%';
        line.set('icons', icons);
    }, 100);
}




//function to decrypt web api error message
function decryptErrorMessage(e) {
    //console.log(e);

    try {
        var err = JSON.parse(e.responseText);
        if (err.error_description) {
            return err.error_description;
        }
        else {
            return err.message;
        }

    } catch (e) {
        return err.exceptionMessage;
        //return 'Internal Server Error. Please contact your administrator.';
    }
}

//Stop Asset Interval

function stopAssetInterval() {
    clearInterval(assetInterval);
}


function functionOn(_functionName) {
    if (currentFunctionStatus) {

        if (currentFunctionStatus['functionName'] == _functionName) {
            currentFunctionStatus['functionName'] = _functionName;
            currentFunctionStatus['value'] = true;
        }
        else {
            functionOff(_functionName);
        }
    }
    else {
        currentFunctionStatus = new functionStatus(_functionName, true);
    }
}

function functionOff(_functionName) {
    if (currentFunctionStatus) {
        currentFunctionStatus['value'] = true;
        switch (currentFunctionStatus.functionName) {
            case 'ruler':
                rulerOff();
                break;
            case 'nearestAsset':
                nearestAssetModeOff();
                break;
            case 'historyPlayback':
                historyPlaybackOff();
                break;
            default:
        }
        currentFunctionStatus['functionName'] = _functionName;

    }
}


//nearest asset



function overlayOff(overlay) {
    switch (overlay) {
        case 'zone':
            zoneList.forEach(function (z) {
                z.setMap(null);
                z['label'].close(map);
            });
            break;
        case 'landmark':
            pointOfInterestList.forEach(function (p) {
                p.setMap(null);
                p['label'].close(map);
            });
            break;
        case 'assets':
            objectMarkers.forEach(function (o) {
                o.setMap(null);
            });
            break;
        default:
    }
}

function overlayOn(overlay) {
    switch (overlay) {
        case 'zone':
            zoneList.forEach(function (z) {
                z.setMap(map);
                z['label'].open(map);
            });
            break;
        case 'landmark':
            pointOfInterestList.forEach(function (p) {
                p.setMap(map);
                p['label'].open(map);
            });
            break;
        case 'assets':
            objectMarkers.forEach(function (o) {
                o.setMap(map);
            });
            break;
        default:
    }
}

//Set Refresh Interval

function startAssetInterval() {

    assetInterval = setInterval(function () {
        overWriteSelectedObject(satvm.SelectedObjectSettings().objectId);
        getObjectSettings();
    }, 30000);

}

//fuel type model for dropdown

function fuelTypeModel(_fuelTypeId, _fuelTypeName) {
    this.fuelTypeId = _fuelTypeId,
    this.fuelTypeName = _fuelTypeName
}

function distanceLimitModel(_distanceLimitValue, _distanceLimitLabel) {
    this.distanceLimitValue = _distanceLimitValue,
    this.distanceLimitLabel = _distanceLimitLabel
}

$('#cbx_overlay_zone').prop('checked', true);
$('#cbx_overlay_landmark').prop('checked', true);
$('#cbx_overlay_assets').prop('checked', true);
$('#cbx_overlay_track').prop('checked', true);
$('#cbx_overlay_traffic').prop('checked', true);
$('#cbx_overlay_interval').prop('checked', true);

$('#cbx_overlay_zone').on('click', function () {
    var isChecked = $(this).prop('checked');
    if (isChecked) {
        overlayOn('zone');
    }
    else {
        overlayOff('zone');
    }
    return true;
});

$('#cbx_overlay_landmark').on('click', function () {
    var isChecked = $(this).prop('checked');
    if (isChecked) {
        overlayOn('landmark');
    }
    else {
        overlayOff('landmark');
    }
    return true;
});

$('#cbx_overlay_assets').on('click', function () {
    var isChecked = $(this).prop('checked');
    if (isChecked) {
        overlayOn('assets');
    }
    else {
        overlayOff('assets');
    }
    return true;
});

$('#cbx_overlay_traffic').on('click', function () {
    var isChecked = $(this).prop('checked');
    if (isChecked) {
        showTraffic();
    }
    else {
        hideTraffic();
    }
    return true;
});


$('#cbx_overlay_interval').on('click', function () {
    var isChecked = $(this).prop('checked');

    if (isChecked) {
        console.log("ischecked");
        startAssetInterval();
    }
    else {

        console.log("isnotchecked");
        stopAssetInterval();
    }
    return true;
});

//SHOW TRAFFIC LAYER
function showTraffic() {

    var trafficLayer = new google.maps.TrafficLayer();
    trafficLayer.setMap(map);

}


//HIDE TRAFFIC LAYER
function hideTraffic() {

    var trafficLayer = new google.maps.TrafficLayer();
    trafficLayer.setMap(null);

}

// Define the overlay
function overlayLabel(opt_options) {
    //this.setValues(opt_options);
    var span = this.span_ = document.createElement('span');
    span.style.cssText = 'position: relative; left: -50%; top: -10px;color:white; ' +
                         'white-space: nowrap;font-size:15px;font-weight:600;' +
                         'padding: 2px;text-shadow: 2px 2px 3px rgba(101, 129, 165, 1);';

    var div = this.div_ = document.createElement('div');
    div.appendChild(span);
    div.style.cssText = 'position: absolute; display: none';
}
overlayLabel.prototype = new google.maps.OverlayView();
// Label for Ruler Marker
overlayLabel.prototype.onAdd = function () {
    var pane = this.getPanes().floatPane;
    pane.appendChild(this.div_);
    var me = this;
    this.listeners_ = [
        google.maps.event.addListener(this, 'position_changed',
            function () { me.draw(); }),
        google.maps.event.addListener(this, 'text_changed',
            function () { me.draw(); })
    ];
};

// Implement onRemove
overlayLabel.prototype.onRemove = function () {
    var i, I;
    this.div_.parentNode.removeChild(this.div_);

    for (i = 0, I = this.listeners_.length; i < I; ++i) {
        google.maps.event.removeListener(this.listeners_[i]);
    }
};

// Implement draw
overlayLabel.prototype.draw = function () {
    var projection = this.getProjection();
    var position = projection.fromLatLngToDivPixel(this.get('position'));

    var div = this.div_;
    div.style.left = position.x + 'px';
    div.style.top = position.y + 'px';
    div.style.display = 'block';

    this.span_.innerHTML = this.get('text').toString();
};


