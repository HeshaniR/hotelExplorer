<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hotel Chain</title>
</head>
<div id="header">
    <%@ include file="./fragments/header.jspf" %>
</div>

<body>
<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading"><h1>Hotel Chain SL Home Page</h1></div>
        <div class="panel-body">

            <form action="/add" class="form-horizontal" method="GET">
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-primary" value="Add Hotel"/>
                    </div>
                </div>
            </form>

            <form action="/search" class="form-horizontal" method="GET">
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-warning" value="Search Hotel"/>
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
