<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>Add Hotel</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?key=AIzaSyARnfrrY6BwdvVAbYDFjmIFEtIoFpjIMYk" async defer></script>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.1.1.min.js"></script>

    <script type="text/javascript">
        var latLng;
        var map;
        var marker;

        $(document).ready(function () {
            navigator.geolocation.getCurrentPosition(initialize);
        });

        var geocoder = new google.maps.Geocoder();

        function geocodePosition(pos) {
            geocoder.geocode({
                latLng: pos
            }, function (responses) {
                if (responses && responses.length > 0) {
                    updateMarkerAddress(responses[0].formatted_address);
                } else {
                    updateMarkerAddress('Cannot determine address at this location.');
                }
            });
        }

        function updateMarkerStatus(str) {
            document.getElementById('markerStatus').innerHTML = str;
        }

        function updateMarkerPosition(latLng) {
            document.getElementById('info').innerHTML = [
                latLng.lat(),
                latLng.lng()
            ].join(', ');
            document.getElementById('lati').value = latLng.lat();
            document.getElementById('longi').value = latLng.lng();
            var panorama = new google.maps.StreetViewPanorama(
                document.getElementById('pano'), {
                    position: latLng,
                    pov: {
                        heading: 34,
                        pitch: 10
                    }
                });
            map.setStreetView(panorama);
        }

        function updateMarkerAddress(str) {
            document.getElementById('address').innerHTML = str;
        }

        function getCurrent() {
            document.getElementById("current").disabled = true;
            navigator.geolocation.getCurrentPosition(showCurrent);
        }

        function showCurrent(position) {
            var current = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            map = new google.maps.Map(document.getElementById('mapCanvas'), {
                zoom: 12,
                center: current,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            if (marker && marker.setMap) {
                marker.setMap(null);
            }

            marker = new google.maps.Marker({
                position: current,
                title: 'Your Location',
                map: map,
                draggable: true
            });
            updateMarkerPosition(current);
            geocodePosition(current);
            initialize(position);
        }

        function initialize(position) {
            latLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            map = new google.maps.Map(document.getElementById('mapCanvas'), {
                zoom: 12,
                center: latLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            marker = new google.maps.Marker({
                position: latLng,
                title: 'Drag this to your location',
                icon: '${pageContext.request.contextPath}/resources/images/Map-Marker-Ball-Chartreuse-icon.png',
                map: map,
                draggable: true
            });

            // Update current position info.
            updateMarkerPosition(latLng);
            geocodePosition(latLng);

            // Add dragging event listeners.
            google.maps.event.addListener(marker, 'dragstart', function () {
                updateMarkerAddress('Dragging...');
            });

            google.maps.event.addListener(marker, 'drag', function () {
                updateMarkerStatus('Dragging...');
                updateMarkerPosition(marker.getPosition());
            });

            google.maps.event.addListener(marker, 'dragend', function () {
                updateMarkerStatus('Drag ended');
                document.getElementById("current").disabled = false;
                geocodePosition(marker.getPosition());
            });
        }

        // Onload handler to fire off the app.
        google.maps.event.addDomListener(window, 'load', initialize);


    </script>

    <style>
        #mapCanvas, #pano {
            float: left;
            height: 100%;
            width: 50%;
        }

        #infoPanel {
            float: left;
            margin-left: 10px;
        }

        #infoPanel div {
            margin-bottom: 5px;
        }
    </style>

</head>

<div id="header">
    <%@ include file="./fragments/header.jspf" %>
</div>

<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>Add Hotel</h1></div>
        <div class="panel-body">
            <form class="form-horizontal" method="post" action="/add">
                <div class="form-group">
                    <label class="control-label col-sm-2">Hotel Name:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="name" placeholder="Enter Hotel Name"
                               value="${hotel.getName()}"
                               required/><br>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Address:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="address" placeholder="Enter Hotel Address"
                               value="${hotel.getAddress()}"
                               required/><br>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">City:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="city" placeholder="Enter City"
                               value="${hotel.getCity()}"
                               required/><br>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Longitude:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="longi" name="longitude"
                               value="${hotel.getLongitude()}"
                               placeholder="Enter Longitude"
                               required/><br>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2">Latitude:</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="lati" name="latitude" placeholder="Enter Latitude"
                               value="${hotel.getLatitude()}"
                               required/><br>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2"></label>
                    <button type="button" id="current" onclick="getCurrent()" class="btn btn-primary">Get Current
                        Location
                    </button>
                </div>

                <div class="form-group">
                    <div id="mapCanvas"></div>
                    <div id="pano"></div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-2"></label>
                    <div id="infoPanel">
                        <b>Marker status:</b>
                        <div id="markerStatus"><i>Click and drag the marker.</i></div>
                        <b>Current position:</b>
                        <div id="info"></div>
                        <b>Closest matching address:</b>
                        <div id="address"></div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-success" value="Submit"/>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
</body>

<div id="footer">
    <%@ include file="./fragments/footer.jspf" %>
</div>
</html>
