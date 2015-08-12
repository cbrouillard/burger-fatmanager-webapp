<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">
    <div class="panel panel-primary">
        <div class="panel-body">
            <g:form action="saveprofile" method="post">
                <div class="form-group">
                    <label for="artistName">Artist name</label>
                    <input type="text" class="form-control" id="artistName" placeholder="Pseudonym / name">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" placeholder="Security">
                </div>
                <div class="form-group">
                    <label for="passwordCheck">Password check</label>
                    <input type="passwordCheck" class="form-control" id="passwordCheck" placeholder="Security check">
                </div>
                <button type="submit" class="btn btn-default">Save</button>
            </g:form>
        </div>
    </div>
</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>