<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="alert alert-info">
        This website will soon be able to provide a way to manage your ".sav" files.
        <ul>
            <li>backup management and sharing</li>
            <li>kits/samples management and sharing</li>
            <li>online ROM "hot" building with all kits you ever wish !</li>
        </ul>
        Keep in touch ! and have fun with FAT !
    </div>
</div>


<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <div class="panel panel-primary">
        <div id="carousel-fat" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-fat" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-fat" data-slide-to="1"></li>
                <li data-target="#carousel-fat" data-slide-to="2"></li>
                <li data-target="#carousel-fat" data-slide-to="3"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active center">
                    <img src="${resource(dir: 'images', file: 'promo3.png')}">

                    <div class="carousel-caption">
                        Intro screen
                    </div>
                </div>

                <div class="item center">
                    <img src="${resource(dir: 'images', file: 'screen_song.png')}">

                    <div class="carousel-caption">
                        Song screen, the sequencer
                    </div>
                </div>

                <div class="item center">
                    <img src="${resource(dir: 'images', file: 'screen_live.png')}">

                    <div class="carousel-caption">
                        Live screen ! Make it sound loud && FAT !
                    </div>
                </div>

                <div class="item center">
                    <img src="${resource(dir: 'images', file: 'keyboard_save.png')}">

                    <div class="carousel-caption">
                        Save tracks on your GBA.
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-fat" role="button" data-slide="prev">
            </a>
            <a class="right carousel-control" href="#carousel-fat" role="button" data-slide="next">
            </a>
        </div>
    </div>

    <div class="well text-justify">
        <p>
            <span class="label label-info">FAT ?</span> The aim of FAT is to provide a simple tool to compose chiptune tracks on your GBA.
        You can freely download the rom in order to test it on an emulator or, better!, on your true GameboyAdvance.
        Documentation is also available (only in french for the moment, sorry).</p>

        <p><span
                class="label label-danger">In case you found a bug</span> Crap ! but please ! feel free to report it ! It's really important to me to know every problems FAT could have. Thanks !
        </p>
    </div>

</div>

<div class="col-xs-12 col-lg-3">

    <div class="panel panel-primary">

        <div class="panel-body">
            <a href="http://brouillard.me/shared/FAT_v1.0.0.gba"
               class="btn btn-lg btn-success btn-block">Download ROM (.gba)</a>
            <a href="http://brouillard.me/shared/FAT_documentation_FR.pdf"
               class="btn btn-lg btn-warning btn-block">Download Documentation (.pdf FR)</a>
            <a href="https://twitter.com/Spintr0nic"
               class="btn btn-lg btn-info btn-block">Follow me on Twitter</a>

            <hr/>

            <a href="https://github.com/cbrouillard/furiousadvancetracker/issues"
               class="btn btn-lg btn-default btn-block">Report an issue</a>
            <a href="https://github.com/cbrouillard/furiousadvancetracker"
               class="btn btn-lg btn-default btn-block">Fork the code on Github</a>

            <hr/>

            <div class="text-right">
                <small>Current version : 1.0.0 pre-release</small>
            </div>

        </div>

    </div>

    %{--<div class="panel panel-primary">

        <div class="panel-heading">
            <h3><g:message code="login"/></h3>
        </div>

        <div class="panel-body">

            <form class="form-signin" action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>

                <label for="username" class="sr-only"><g:message code="user"/></label>
                <input type="text" name='j_username' id='username' class="form-control"
                       placeholder="Votre id utilisateur"
                       required
                       autofocus>

                <label for="password" class="sr-only"><g:message code="password"/></label>
                <input type="password" name='j_password' id='password' class="form-control"
                       placeholder="Votre mot de passe"
                       required>

                <div class="checkbox">
                    <label>
                        <input type="checkbox" name='${rememberMeParameter}' id='remember_me'
                               <g:if test='${hasCookie}'>checked='checked'</g:if>/> <g:message code="remember.me"/>
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit"><g:message code="login"/></button>
            </form>
        </div>

    </div>--}%

</div>

</body>
</html>