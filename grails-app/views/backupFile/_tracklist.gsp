<g:each in="${file.tracks}" var="track" status="j">
    <div class="col-lg-3 col-md-4 col-sm-4" id="${track.id}">
        <div class="panel panel-success">
            <div class="panel-heading">
                <span class="badge">#${j + 1}</span>

                <div class="pull-right">
                    <div class="btn-group">
                        <g:link controller="backupFile" class="btn btn-xs btn-success"
                                action="downloadTrack"
                                id="${track.id}">
                            <span class="glyphicon glyphicon-download"></span>
                        </g:link>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div>${track.name}</div>

                <div><span class="label label-info">${track.size} bytes</span></div>
            </div>
        </div>
    </div>
</g:each>