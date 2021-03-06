<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Your profile</div>
</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <g:hasErrors bean="${user}">
        <div class="alert-danger alert">
            <ul class="errors" role="alert">
                <g:eachError bean="${user}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </div>
    </g:hasErrors>

    <div class="panel panel-primary">
        <div class="panel-body">
            <g:form controller="person" action="saveprofile" method="post" data-toggle="validator">
                <div class="form-group">
                    <label for="artistName">Artist name</label>
                    <input type="text" class="form-control" id="artistName" name="artistName" placeholder="Pseudonym / name" value="${user?.artistName}" required="">
                    <div class="help-block with-errors"></div>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Minimum 6 characters">
                </div>
                <div class="form-group">
                    <label for="passwordCheck">Password check</label>
                    <input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="Retype your password">
                </div>
                <hr/>
                <button type="submit" class="btn btn-default pull-right">Save</button>
            </g:form>
        </div>
    </div>
</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>