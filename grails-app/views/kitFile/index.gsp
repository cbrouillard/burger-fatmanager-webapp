<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Kits and samples management</div>

    <div class="marginedbottom">

        <g:hasErrors bean="${kitFileInstance}">
            <div class="alert-danger alert">
                <ul class="errors" role="alert">
                    <g:eachError bean="${kitFileInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </g:hasErrors>

        <g:form action="save" class="form-inline" data-toggle="validator">
            <span class="badge">Add a new kit</span>

            <div class="form-group">
                <label class="sr-only" for="name">Kit name</label>
                <input type="text" class="form-control" id="name" name="name"
                       placeholder="New kit name" required="" data-maxlength="8">
            </div>

            <button type="submit" class="btn btn-default" name="btnsubmit" value="create">Create new one</button>

        </g:form>
    </div>

</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${kitFileInstanceList}">
        <g:each in="${kitFileInstanceList}" var="file" status="i">
            <div id="${file.id}">
                <g:render template="onekitfile" model="[file: file]"/>
            </div>
        </g:each>
    </g:if>
    <g:else>
        <div class="alert alert-info marginedtop">You don't have any kit here. You can create a new one with the form above : provide your name and click "Create". That's it !</div>
    </g:else>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>