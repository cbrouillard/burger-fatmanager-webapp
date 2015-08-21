<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:message code="app.name"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">

    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:layoutHead/>
</head>

<body>

<sec:ifLoggedIn>
    <nav class="navbar navbar-default navbar-static-top fattop-nav" role="navigation">
        <div class="container-fluid">
            <div class="col-lg-8 col-lg-offset-2 col-xs-12">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#navbar-collapse-1">
                        <span class="sr-only">Toggle</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="navbar-collapse-1">

                    <ul class="nav navbar-nav">
                        <li class="${controllerName == 'backupFile' ? "active" : ""}"><g:link controller="backupFile"
                                                                                              action="index">Backup and tracks</g:link></li>
                        <li class="${controllerName == 'kitFile' ? "active" : ""}"><g:link controller="kitFile">Kits and samples</g:link></li>

                        <li class="${controllerName == 'rom' ? "active" : ""}"><g:link controller="rom">ROM builder</g:link></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="${controllerName == 'person' ? "active" : ""}">
                            <g:link controller="person" action="profile"><span
                                    class="glyphicon glyphicon-heart"></span> ${sec.loggedInUserInfo(field: "username")}</g:link>
                        </li>

                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li class="${controllerName == 'admin' ? "active" : ""}">
                                <g:link controller="admin" action="console">Administration</g:link>
                            </li>
                        </sec:ifAllGranted>

                        <sec:ifSwitched>
                            <li>
                                <a href='${request.contextPath}/j_spring_security_exit_user'>
                                    <span class="label label-danger">QUIT ADMIN MODE</span>
                                </a>
                            </li>
                        </sec:ifSwitched>

                        <li><g:link controller="logout">Logout</g:link></li>
                    </ul>

                </div><!-- /.navbar-collapse -->
            </div>
        </div><!-- /.container-fluid -->

    </nav>
</sec:ifLoggedIn>

<div class="header-content">
    <div class="container-fluid">
        <div class="col-lg-8 col-lg-offset-2 col-xs-12">
            FAT
            <div class="disclaimer">
                FuriousAdvanceTracker, FAT, is a GBA tracker.
            </div>

            <div class="disclaimer">
                This free software allows you to make some music on your GameBoy Advance system.
            </div>

            <div class="disclaimer">
                <sec:ifNotLoggedIn>
                    <form class="form-inline" autocomplete='off' action='${request.contextPath}/j_spring_security_check'
                          method='POST' id='loginForm'
                          autocomplete='off' aria-autocomplete="off">
                        <div class="form-group">
                            <label class="sr-only" for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="j_username"
                                   placeholder="Username">
                        </div>

                        <div class="form-group">
                            <label class="sr-only" for="password">Password</label>
                            <input type="password" class="form-control" name="j_password" id="password"
                                   placeholder="Password">
                        </div>
                        <button type="submit" class="btn btn-default">Sign in</button>
                        <g:link controller="person" action="askregister" class="btn btn-warning">Register</g:link>
                    </form>
                    <g:if test='${flash.message}'>
                        <div class='message-normal alert-info alert'>${flash.message}</div>
                    </g:if>
                </sec:ifNotLoggedIn>
            </div>

        </div>
    </div>
</div>

<div class="container-fluid">
    <g:layoutBody/>
</div>

<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
    <div class="navbar-inner">
        <div class="container-fluid">
            <div class="col-lg-8 col-lg-offset-2 col-xs-12">
                <p class="navbar-text pull-left">
                    <span style="-webkit-transform: rotate(180deg); -moz-transform: rotate(180deg); -o-transform: rotate(180deg); -khtml-transform: rotate(180deg); -ms-transform: rotate(180deg); transform: rotate(180deg); display: inline-block;"
                          class="grand">&copy;</span>
                    BROUILLARD Cyril - [2011-2015] - <g:message
                            code="app.name"/> - a GBA Tracker with a cool fat cat !</p>
            </div>

        </div>
    </div>
</nav>
</body>
<jq:jquery>
  $('[data-toggle="popover"]').popover()
</jq:jquery>
</html>
