<!DOCTYPE html>
<html>
<head>
    <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
    <meta name="layout" content="main">
    <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
</head>

<body>
<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <g:if env="development">
        <g:renderException exception="${exception}"/>
    </g:if>
    <g:else>
        <div class="alert alert-danger">Sorry but an error has occured.</div>
    </g:else>
</div>
</body>
</html>
