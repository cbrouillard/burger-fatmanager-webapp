<div class="panel panel-primary">
    <div class="panel-heading">

        <div class="pull-right">
            <g:if test="${!hideAddAction}">
                <g:link controller="backupFile" class="btn btn-default"
                        action="selectTrack"
                        id="${file.id}">Manage tracks</g:link>
            </g:if>

            <div class="btn-group">
                <g:link controller="backupFile" class="btn btn-success" action="download"
                        id="${file.id}">
                    <span class="glyphicon glyphicon-download"></span>
                </g:link>
                <g:if test="${!hideDeleteAction}">
                    <g:remoteLink controller="backupFile" resource="${file}" class="btn btn-danger"
                                  action="delete"
                                  id="${file.id}" after="fadeOut('${file.id}')">
                        <span class="glyphicon glyphicon-trash"></span>
                    </g:remoteLink>
                </g:if>
            </div>
        </div>

        <g:if test="${file.name}">
            ${file.name}
        </g:if>
        <span class="label label-info"><g:formatDate date="${file.dateCreated}"/></span>
        <span class="label label-info">${file.tracks.size()} tracks</span>

        <div class="clearfix">&nbsp;</div>
    </div>

    <g:if test="${file.tracks}">
        <div class="panel-body">
            <g:render template="tracklist" model="[file: file]"/>
        </div>
    </g:if>
</div>