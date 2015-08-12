<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <div class="page-title">Backup files management</div>

    <g:uploadForm action="save" class="form-inline">
        <div class="form-group">
            <label class="sr-only" for="savfile">Password</label>
            <input type="file" class="file" name="savfile" id="savfile"
                   placeholder="File (.sav)"
                   data-show-preview="false"
                   data-show-upload="false"
                   data-show-caption="true">
        </div>

        <div class="form-group">
            <label class="sr-only" for="name">Backup name</label>
            <input type="text" class="form-control" id="name" name="name"
                   placeholder="Backup name">
        </div>

        <button type="submit" class="btn btn-default">Send</button>
    </g:uploadForm>

    <g:if test="${backupFileInstanceList}">
    <g:each in="${backupFileInstanceList}" var="file" status="i">
        <div class="panel panel-primary marginedtop">
            <div class="little-title">

                <div class="pull-right">
                    <div class="btn-group">
                        <g:link controller="backupFile" class="btn btn-danger" action="delete"
                                id="${file.id}">Delete</g:link>
                    </div>
                </div>

                #${i + 1} ${file.name}
                <span class="label label-info"><g:formatDate date="${file.dateCreated}"/></span>
                <span class="label label-info">${file.tracks.size()} tracks</span>

                <div class="clearfix">&nbsp;</div>
            </div>

            <g:if test="${file.tracks}">
                <table class="table">
                    <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th>Name</th>
                        <th>Size</th>
                        <th>&nbsp;</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${file.tracks}" var="track" status="j">
                        <tr>
                            <td>#${j + 1}</td>
                            <td>${track.name}</td>
                            <td>${track.size}</td>
                            <td>
                                <div class="btn-group">
                                    <g:link class="btn btn-danger" action="delete" id="${track.id}">Delete</g:link>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
        </div>
    </g:each>
    </g:if>
    <g:else>
        <div class="alert alert-info marginedtop">You don't have any backup files here. You can send a new one with the form above : simply browse for a FAT's ".sav" file, name it if you wish and click send !</div>
    </g:else>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>