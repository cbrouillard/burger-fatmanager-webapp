<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
%{--<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="alert alert-info">
        This website will soon be able to provide a way to manage your ".sav" files.
        <ul>
            <li>backup management and sharing</li>
            <li>kits/samples management and sharing</li>
            <li>online ROM "hot" building with all kits you ever wish !</li>
        </ul>
        Keep in touch ! and have fun with FAT !
    </div>
</div>--}%


<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <div class="panel panel-primary">
        <div id="carousel-fat" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-fat" data-slide-to="0" class="active"></li>
                <li data-target="#carousel-fat" data-slide-to="1"></li>
                <li data-target="#carousel-fat" data-slide-to="2"></li>
                <li data-target="#carousel-fat" data-slide-to="3"></li>
                <li data-target="#carousel-fat" data-slide-to="4"></li>
                <li data-target="#carousel-fat" data-slide-to="5"></li>
                <li data-target="#carousel-fat" data-slide-to="6"></li>
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
                    <img src="${resource(dir: 'images', file: 'screen_project.png')}">

                    <div class="carousel-caption">
                        The project management screen
                    </div>
                </div>

                <div class="item center">
                    <img src="${resource(dir: 'images', file: 'screen_song.png')}">

                    <div class="carousel-caption">
                        Song screen, the sequencer
                    </div>
                </div>

		<div class="item center">
                    <img src="${resource(dir: 'images', file: 'screen_popup.png')}">

                    <div class="carousel-caption">
			Switch between features with the FAT popup
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

		<div class="item center">
                    <img src="${resource(dir: 'images', file: 'smartphone.png')}">

                    <div class="carousel-caption">
                        Smartphone compatible ! (with emulator)
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
            <span class="label label-success">FAT ?</span> The aim of FAT is to provide a simple tool to compose chiptune tracks on your GBA.
        You can freely download the ROM file in order to test it with an emulator or, better!, with your true GameboyAdvance.
        Documentation is also available (only in french for the moment, sorry).</p>

        <p>
            <span class="label label-warning">Why register here ?</span> Because you'll probably want to manage all your FAT's stuff such as tracks or kits ! This webapp allow you to do that ! Save your tracks, reorganize your backups files, share your samples ... and more !
        </p>

        <p><span
                class="label label-info">In case you found a bug</span> Crap ! but please ! feel free to report it ! It's really important to me to know every problems FAT could have. Thanks !
        </p>
    </div>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>
