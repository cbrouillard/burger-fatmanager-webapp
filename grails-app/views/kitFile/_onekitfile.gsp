<g:if test="${message}">
    <div class="alert alert-info">${message}</div>
</g:if>

<div class="panel panel-primary">
    <div class="panel-heading">

        <div class="pull-right">
            <g:if test="${!hideAddAction}">
                <g:link controller="kitFile" class="btn btn-default"
                        action="selectSamples"
                        id="${file.id}">Manage samples</g:link>
            </g:if>

            <div class="btn-group">
                <g:if test="${!hideDeleteAction}">
                    <g:remoteLink controller="kitFile" resource="${file}" class="btn btn-danger"
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
        <span class="label label-info">${file.samples.size()} samples</span>

        <div class="clearfix">&nbsp;</div>
    </div>

    <g:if test="${file.samples}">
        <div class="panel-body">
            <g:render template="samplelist" model="[file: file]"/>
        </div>
    </g:if>
</div>