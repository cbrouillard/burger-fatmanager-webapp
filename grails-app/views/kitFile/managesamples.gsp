<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Manage samples in kit file ${file.name}</div>
</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <div id="${file.id}">
        <g:render template="onekitfile" model="[file: file, hideAddAction: true, hideDeleteAction: true]"/>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <div class="pull-right">
                <g:uploadForm action="sendSample" class="form-inline">
                    <div class="form-group">
                        <label class="sr-only" for="soundfile">Sound file</label>
                        <input type="file" class="file" name="soundfile" id="soundfile"
                               placeholder="Sound file (.wav | .mp3 | .ogg)"
                               data-show-preview="false"
                               data-show-upload="false"
                               data-show-remove="false"
                               data-show-caption="true"
                               data-browse-class="btn btn-success"
                               data-browse-label="Browse for sound file">
                    </div>

                    <input type="hidden" name="kit" value="${file.id}"/>
                    <button type="submit" class="btn btn-default" name="btnsubmit" value="send">Send sound file</button>
                </g:uploadForm>
            </div>

            Available samples
            <div class="clearfix">&nbsp;</div>
        </div>


        <div class="panel-body table-responsive">
            <g:if test="${samples}">
                <table class="table table-hover">
                    <thead><tr><th>&nbsp;</th><th>Sample name</th><th>&nbsp;</th></tr></thead>
                    <tbody>
                    <g:each in="${samples}" var="sample" status="j">
                        <tr>
                            <td><span class="badge">#${j + 1}</span></td>
                            <td>
                                ${sample.name}
                            </td>
                            <td class="text-right">
                                <g:if test="${file.samples.contains(sample)}">
                                    <g:remoteLink class="btn btn-default" controller="kitFile"
                                                  action="unlinkSample"
                                                  id="${sample.id}" params="[file: file.id]"
                                                  update="${file.id}">Remove from file
                                    </g:remoteLink>
                                </g:if>
                                <g:else>
                                    <g:remoteLink controller="kitFile" action="addSample" id="${sample.id}"
                                                  params="[file: file.id]"
                                                  class="btn btn-default"
                                                  update="${file.id}">Add in file</g:remoteLink>
                                </g:else>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                <div class="alert alert-info">No available samples to add</div>
            </g:else>
        </div>

    </div>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>