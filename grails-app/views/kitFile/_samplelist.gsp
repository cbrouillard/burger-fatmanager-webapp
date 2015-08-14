<g:each in="${file.samples}" var="sample" status="j">
    <div class="col-lg-3 col-md-4 col-sm-4" id="${sample.id}">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <span class="badge">#${j + 1}</span>

                <div class="pull-right">
                    <div class="btn-group">
                        <g:link controller="kitFile" class="btn btn-xs btn-success"
                                action="downloadSample"
                                id="${sample.id}">
                            <span class="glyphicon glyphicon-download"></span>
                        </g:link>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div>${sample.name}</div>
            </div>
        </div>
    </div>
</g:each>