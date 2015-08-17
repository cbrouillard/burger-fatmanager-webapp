<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Manage tracks in backup file ${file.name}</div>
</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <div id="${file.id}">
        <g:render template="onebackupfile" model="[file: file, hideAddAction: true, hideDeleteAction: true]"/>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading">Available tracks</div>

        <div class="panel-body table-responsive">

            %{--  <div class="alert alert-danger">
                  <span class="glyphicon glyphicon-trash"></span> Deletion (red "Delete" action) is irreversible. Track will be deleted from all sav files.
              </div>
  --}%
            <table class="table table-hover">
                <thead><tr><th>&nbsp;</th><th>Track name</th><th>Size</th><th>&nbsp;</th></tr></thead>
                <tbody>
                <g:each in="${tracks}" var="track" status="j">
                    <tr id="tr${track.id}">
                        <td>
                            %{--<g:remoteLink controller="backupFile"
                                          action="deleteTrack"
                                          id="${track.id}"
                                          class="btn btn-danger"
                                          after="fadeOut('#tr${track.id}')"><span
                                    class="glyphicon glyphicon-trash"></span> Delete</g:remoteLink>--}%
                            <span class="badge">#${j + 1}</span></td>
                        <td>
                            ${track.name}
                        </td>
                        <td>
                            ${track.size} bytes
                        </td>
                        <td class="text-right">
                            <span id="unlink${track.id}" class="${file.tracks.contains(track) ? '' : 'hiddenBtn'}">
                                <g:remoteLink class="btn btn-default" controller="backupFile"
                                              action="unlinkTrack"
                                              id="${track.id}" params="[file: file.id]"
                                              update="${file.id}"
                                              after="showAndHide('add${track.id}', 'unlink${track.id}')">Remove from file
                                </g:remoteLink>
                            </span>

                            <span id="add${track.id}" class="${file.tracks.contains(track) ? 'hiddenBtn' : ''}">
                                <g:remoteLink controller="backupFile" action="addTrack" id="${track.id}"
                                              params="[file: file.id]"
                                              class="btn btn-default"
                                              update="${file.id}"
                                              after="showAndHide('unlink${track.id}', 'add${track.id}')">Add in file</g:remoteLink>
                            </span>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>

    </div>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>