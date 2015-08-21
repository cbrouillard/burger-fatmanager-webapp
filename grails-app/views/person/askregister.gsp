<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Register</div>
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
            <g:form controller="person" action="register" method="post"  data-toggle="validator">
                <div class="form-group">
                    <label for="username">Email</label>
                    <input type="email" class="form-control" id="username" name="username" placeholder="Your email. Will be used for validation. Will be your username."
                           value="${user?.username}" required="">
                    <div class="help-block with-errors"></div>
                </div>

                <div class="form-group">
                    <label for="artistName">Artist name</label>
                    <input type="text" class="form-control" id="artistName" name="artistName"
                           placeholder="Pseudonym / name. This is NOT your username." value="${user?.artistName}" required="">
                    <div class="help-block with-errors"></div>
                </div>

                <div class="form-group">
                    <label for="passwordNew">Password</label>
                    <input type="password" class="form-control" id="passwordNew" name="passwordNew" placeholder="Security is important : 6 characters minimum." required="" data-minlength="6">
                    <div class="help-block with-errors"></div>
                </div>

                <div class="form-group">
                    <label for="passwordCheck">Password check</label>
                    <input type="password" class="form-control" id="passwordCheck" name="passwordCheck"
                           placeholder="Retype your password" required="" data-match-error="Pasword do not match" data-match="#passwordNew">
                    <div class="help-block with-errors"></div>
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