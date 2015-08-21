<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Backup and tracks management</div>

    <div class="marginedbottom">
        <g:uploadForm action="save" class="form-inline">
            <span class="badge">Create backup</span>

            <div class="form-group">
                <label class="sr-only" for="savfile">.sav file</label>
                <input type="file" class="file" name="savfile" id="savfile"
                       placeholder="File (.sav)"
                       data-show-preview="false"
                       data-show-upload="false"
                       data-show-remove="false"
                       data-show-caption="true"
                       data-browse-class="btn btn-success"
                       data-browse-label="Browse for .sav file">
            </div>

            <div class="form-group">
                <label class="sr-only" for="name">Backup name</label>
                <input type="text" class="form-control" id="name" name="name"
                       placeholder="Backup name">
            </div>

            <button type="submit" class="btn btn-default" name="btnsubmit" value="create">Create</button>

        </g:uploadForm>
    </div>

</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">



    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${backupFileInstanceList}">
        <g:each in="${backupFileInstanceList}" var="file" status="i">
            <div id="${file.id}">
                <g:render template="onebackupfile" model="[file: file]"/>
            </div>
        </g:each>
    </g:if>
    <g:else>
        <div class="alert alert-info">You don't have any backup files here. You can send a new one with the form above : simply browse for a FAT's ".sav" file, name it if you wish and click send !</div>
    </g:else>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>