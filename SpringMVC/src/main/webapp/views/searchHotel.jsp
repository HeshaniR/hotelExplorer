<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Hotels</title>
    <style type="text/css">
        .black_overlay {
            display: none;
            position: fixed;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1001;
            -moz-opacity: 0.8;
            opacity: .80;
            filter: alpha(opacity=80);
        }

        .white_content {
            display: none;
            position: fixed;
            top: 10%;
            right: 10%;
            width: 80%;
            height: 80%;
            padding: 10px;
            background-color: white;
            z-index: 1002;
            overflow: auto;
        }

        #mapCanvas, #pano {
            float: left;
            height: 100%;
            width: 50%;
        }
    </style>

    <script type="text/javascript"
            src="http://maps.google.com/maps/api/js?key=AIzaSyARnfrrY6BwdvVAbYDFjmIFEtIoFpjIMYk" async></script>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.1.1.min.js"></script>

    <script type="application/javascript">
        var types = "name";

        function showMap(link, longi, lati) {
            document.getElementById('light').style.display = 'block';
            document.getElementById('fade').style.display = 'block';
            var location = {lat: lati, lng: longi};
            var map = new google.maps.Map(document.getElementById('mapCanvas'), {
                zoom: 15,
                center: location
            });
            var infowindow = new google.maps.InfoWindow({
                content: "<b>" + link.id + "</b>"
            });
            var marker = new google.maps.Marker({
                position: location,
                map: map
            });
            var panorama = new google.maps.StreetViewPanorama(
                document.getElementById('pano'), {
                    position: location,
                    pov: {
                        heading: 34,
                        pitch: 10
                    }
                });
            map.setStreetView(panorama);
            infowindow.open(map, marker);
        }

        function closeMap() {
            document.getElementById('light').style.display = 'none';
            document.getElementById('fade').style.display = 'none';
        }

        function getList(type) {
            var param = {text: $("#searchBox").val(), type: type};
            $.ajax({
                type: 'POST',
                url: '/search',
                data: param,
                success: function (data) {
                    data = $.parseJSON(data);
                    var code = "";
                    $.each(data, function (i, index) {
                        code += "<div class='col-sm-4 col-lg-4 col-md-4'><div class='thumbnail'><div class='caption'><h4 class='pull-right'></h4><h3>" + index.name + "</h3><h5>" + index.address + "</h5><h4>" + index.city + "</h4><a id='" + index.name + "' href='javascript:void(0)' onclick='showMap(this," + index.longitude + "," + index.latitude + ")'>get location</a></div></div></div>";
                    });
                    if (code.length == 0) {
                        document.getElementById("list").innerHTML = "<h2>Nothing Found</h2>";
                    } else {
                        document.getElementById("list").innerHTML = code;
                    }
                }
            });
        }

        function nameClicked() {
            types = 'name';
            getList(types);
        }

        function cityClicked() {
            types = 'city';
            getList(types);
        }

    </script>

</head>

<div id="header">
    <%@ include file="./fragments/header.jspf" %>
</div>


<body onload="getList(types)">
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>Search Hotel</h1></div>
        <div class="panel-body">

            <div id="light" class="white_content"><a href="javascript:void(0)" onclick="closeMap()"><b>close map</b></a><br>
                <div id='mapCanvas'></div>
                <div id="pano"></div>
            </div>
            <div id="fade" onclick="closeMap()" class="black_overlay"></div>

            <form onsubmit="getList(type)" id="myForm" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-2"></label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" name="text" id="searchBox"
                               placeholder="Enter some text to search"
                               onkeyup="getList(types)" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2"></label>
                    <div class="col-sm-6">
                        <label class="radio-inline"><input type="radio" name="type" onclick="nameClicked()"
                                                           checked>Search By Name</label>
                        <label class="radio-inline"><input type="radio" name="type" onclick="cityClicked()">Search
                            By City</label>
                    </div>
                </div>

            </form>

            <div id="list"></div>
        </div>
    </div>
</div>
</body>

<div id="footer">
    <%@ include file="./fragments/footer.jspf" %>
</div>

</html>
