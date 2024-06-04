////Title: Filter Objects By Status
////Description: Get all objects within a certain status
////Required Libraries:
////Last Update: 2015-07-31

String.prototype.capitalize = function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function filterSelect(obj) {
    satvm.SelectedFilter(obj);
    var x = $('#filtersMenuItem');

    if ($('#filtersMenuItem').hasClass('side-panel-menu-item-active')) {
        //$('.left-side-panel-menu-item').removeClass('side-panel-menu-item-active');
        //$('.left-side-panel-menu-item-container').hide("slide");

    }
    else {
        $('.left-side-panel-menu-item').removeClass('side-panel-menu-item-active');
        $('.left-side-panel-menu-item-container').hide("slide");
        $('#filtersMenuItem').addClass('side-panel-menu-item-active');
        var target = $('#filtersMenuItem').attr('data-slidetoggle');
        $('#' + target).show("slide");

    }


    //if (x.hasClass('side-panel-menu-item-active') === false) {
    //    $('#filtersMenuItem').click();

    //    console.log("yeah");

    //}
    //else {
    //    $('.left-side-panel-menu-item').removeClass('side-panel-menu-item-active');
    //    $('.left-side-panel-menu-item-container').hide("slide");
    //    $(this).addClass('side-panel-menu-item-active');
    //    var target = $(this).attr('data-slidetoggle');
    //    $('#' + target).show("slide");
    //    console.log("alright");
    //}





    setTimeout(function () {

        switch (obj) {
            case 'Total':
                satvm.FilteredObjects(satvm.ObjectGPSInfoList());
                break;
            case 'Active':
                satvm.FilteredObjects(satvm.Active());
                break;
            case 'Inactive':
                satvm.FilteredObjects(satvm.Inactive());
                break;
            case 'Overidling':
                satvm.FilteredObjects(satvm.Overidling());
                break;
            case 'Overspeeding':
                satvm.FilteredObjects(satvm.Overspeeding());
                break;
            case 'Parking':
                satvm.FilteredObjects(satvm.Parking());
                break;
            case 'SOS':
                satvm.FilteredObjects(satvm.SOS());
                break;
            case 'GPS Cut':
                satvm.FilteredObjects(satvm.GpsCut());
                break;
            case 'Battery Cut':
                satvm.FilteredObjects(satvm.BatteryCut());
                break;
            case 'Driving':
                satvm.FilteredObjects(satvm.Driving());
                break;
            case 'Idling':
                satvm.FilteredObjects(satvm.Idling());
                break;
            case 'Go Zone':
                satvm.FilteredObjects(satvm.GoZone());
                break;
            case 'No Zone':
                satvm.FilteredObjects(satvm.NoZone());
                //satvm.NoZone().forEach(function (nz) {
                //    satvm.FilteredObjects.push(nz);
                //})
                //console.log(satvm.FilteredObjects.length);
                break;
            default:
                break;
        }
    }, 500);


}

function filterByStatus(res) {
    //ACC On/Off
    
    var obs = res.status;

    if (obs != null) {
        var statOn = obs.indexOf('ACC On') != -1;
        var statOff = obs.indexOf('ACC Off') != -1;
        var sos = obs.indexOf('SOS') != -1;
        var batteryCut = obs.indexOf('Battery Cut') != -1;
        var gpsCut = obs.indexOf('GPS Cut') != -1;
        var overidle = obs.indexOf('Over Idle') != -1;

        console.log("gpscut: " + gpsCut);

    }



    var objDateString = res.gpsTime.toString();
    var objDate = objDateString.slice(0, 10);
    var objTime = objDateString.slice(11, 19);
    var objDateFormated = new Date(objDate + "T" + objTime);
    var objDateMinus = new Date();
    var today = new Date(Date.now());
    objDateMinus.setDate(today.getDate() - 1);


    var element = $('.status-icon[data-status="' + res.objectId + '"]');



    //Active

    //console.log(objDateFormated + objDateMinus);
    if (objDateFormated > objDateMinus) {


        $(element).css({ "color": "#66ff66" });
        satvm.Active.push(res);

        //Overidling
        if (res.speed === 0 && statOn === true && overidle == true) {
            satvm.Overidling.push(res);
            //red
            $(element).css({ "color": "#ff0000" });
        }

        //Parking
        if (statOff == true) {
            satvm.Parking.push(res);
            //blue
            $(element).css({ "color": "#003399" });
        }

        //Sos
        if (sos == true) {
            satvm.SOS.push(res);
            //red
            $(element).css({ "color": "#ff0000" });
        }

        //Battery Cut
        if (batteryCut == true) {
            satvm.BatteryCut.push(res);
            //yellow
            $(element).css({ "color": "#ffcc00" });
        }

        //GPS Cut
        if (gpsCut == true) {
            satvm.GpsCut.push(res);
            //yellow
            $(element).css({ "color": "#ffcc00" });
        }

        //Driving
        if (statOn == true && res.speed > 0) {
            satvm.Driving.push(res);
            //green
            $(element).css({ "color": "#006600" });
        }

        //Idling
        if (statOn == true && res.speed === 0) {
            satvm.Idling.push(res);
            //light green
            $(element).css({ "color": "#66ff66" });
        }

        //Go/No Zone
        isInsideZone(res.longitude, res.latitude, res);        


    }

    //Inactive
    if (objDateFormated < objDateMinus) {

        var result = objDateFormated < objDateMinus;
        satvm.Inactive.push(res);
        $(element).css({ "color": "gray" });


    }



    $('#lblActive').text(satvm.Active().length);
    $('#lblGoZone').text(satvm.GoZone().length);
    $('#lblNoZone').text(satvm.NoZone().length);
    $('#lblInactive').text(satvm.Inactive().length);
    $('#lblOveridling').text(satvm.Overidling().length);
    $('#lblOverspeeding').text(satvm.Overspeeding().length);
    $('#lblParking').text(satvm.Parking().length);
    $('#lblSOS').text(satvm.SOS().length);
    $('#lblBatteryCut').text(satvm.BatteryCut().length);
    $('#lblGPSCut').text(satvm.GpsCut().length);
    $('#lblDriving').text(satvm.Driving().length);
    $('#lblIdling').text(satvm.Idling().length);

}

function isInsideZone(longitude, latitude, res) {
    if (zoneList.length > 0) {
        var pos = new google.maps.LatLng(latitude, longitude);
        zoneList.forEach(function (zl) {
            if (zl['type'] == 'Polygon') {
                var result = google.maps.geometry.poly.containsLocation(pos, zl);
                if (result == true) {
                    if (zl['allowedZone'] == true) {
                        satvm.GoZone.push(res);
                    }
                    else {
                        satvm.NoZone.push(res);
                    }
                }

                return false;
            }
            else if (zl['type'] == 'Circle') {
                var result = (google.maps.geometry.spherical.computeDistanceBetween(pos, zl.getCenter()) <= zl.getRadius());
                if (result == true) {
                    if (zl['allowedZone'] == true) {
                        satvm.GoZone.push(res);
                    }
                    else {
                        satvm.NoZone.push(res);
                    }
                }

                return false;
            }
        });
    }
}
