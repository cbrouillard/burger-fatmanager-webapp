<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Backup and tracks management</div>
</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:uploadForm action="save" class="form-inline">
        <div class="form-group">
            <label class="sr-only" for="savfile">Password</label>
            <input type="file" class="file" name="savfile" id="savfile"
                   placeholder="File (.sav)"
                   data-show-preview="false"
                   data-show-upload="false"
                   data-show-remove="false"
                   data-show-caption="true">
        </div>

        <div class="form-group">
            <label class="sr-only" for="name">Backup name</label>
            <input type="text" class="form-control" id="name" name="name"
                   placeholder="Backup name">
        </div>

        <button type="submit" class="btn btn-default" name="btnsubmit" value="send">Send .sav file</button>
        <button type="submit" class="btn btn-default" name="btnsubmit" value="create">Create empty one</button>

    </g:uploadForm>

    <g:if test="${flash.message}">
        <div class="alert alert-info marginedtop" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${backupFileInstanceList}">
        <g:each in="${backupFileInstanceList}" var="file" status="i">
            <div class="panel panel-primary marginedtop">
                <div class="panel-heading">

                    <div class="pull-right">
                        <g:link controller="backupFile" class="btn btn-default"
                                action="addtrack"
                                id="${file.id}">Add track</g:link>

                        <div class="btn-group">
                            <g:link controller="backupFile" class="btn btn-success" action="download"
                                    id="${file.id}">
                                <span class="glyphicon glyphicon-download"></span>
                            </g:link>
                            <g:link controller="backupFile" resource="${file}" class="btn btn-danger"
                                    action="delete"
                                    id="${file.id}">
                                <span class="glyphicon glyphicon-trash"></span>
                            </g:link>
                        </div>
                    </div>

                    <span class="label label-warning">#${i + 1}</span>
                    <g:if test="${file.name}">
                        <span class="label label-success">${file.name}</span>
                    </g:if>
                    <span class="label label-info"><g:formatDate date="${file.dateCreated}"/></span>
                    <span class="label label-info">${file.tracks.size()} tracks</span>

                    <div class="clearfix">&nbsp;</div>
                </div>

                <g:if test="${file.tracks}">
                    <div class="table-responsive">
                        <table class="table table-condensed">
                            <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th>Track name</th>
                                <th>Size</th>
                                <th>&nbsp;</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${file.tracks}" var="track" status="j">
                                <tr>
                                    <td><span class="badge">#${j + 1}</span></td>
                                    <td>${track.name}</td>
                                    <td>${track.size} bytes</td>
                                    <td class="text-right">
                                        <div class="btn-group">
                                            <g:link controller="backupFile" class="btn btn-success"
                                                    action="downloadTrack"
                                                    id="${track.id}">
                                                <span class="glyphicon glyphicon-download"></span>
                                            </g:link>
                                            <g:link class="btn btn-danger" controller="backupFile"
                                                    action="deleteTrack"
                                                    id="${track.id}" params="[file: file.id]">
                                                <span class="glyphicon glyphicon-trash"></span>
                                            </g:link>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
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