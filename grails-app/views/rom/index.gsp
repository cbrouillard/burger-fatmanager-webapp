<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Build your own FuriousAdvanceTracker ROM</div>
</div>

<div class="col-xs-12 col-lg-5 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${kits}">

        <div class="panel panel-success">
            <div class="panel-heading">Builder</div>

            <div class="panel-body table-responsive">

                <g:form controller="rom" action="build" method="post" data-toggle="validator">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>&nbsp;</th>
                            <th>Kit name</th>
                            <th>#samples</th>
                            <th class="text-right"><a href="#" class="btn btn-xs btn-default">Select all</a></th>
                        </tr>
                        </thead>

                        <g:each in="${kits}" var="kit" status="i">
                            <tr>
                                <td><span class="badge">#${i + 1}</span></td>
                                <td>
                                    ${kit.name}
                                </td>
                                <td>
                                    ${kit.samples.size()}
                                </td>
                                <td class="text-right">
                                    <g:if test="${kit.samples.size() > 0}">
                                        <g:checkBox name="kit" value="${kit.id}" checked="false"/>
                                    </g:if>
                                    <g:else>
                                        <i>No samples in this kit</i>
                                    </g:else>
                                </td>
                            </tr>
                        </g:each>

                    </table>

                    <hr/>
                    <button type="submit" class="btn btn-default pull-right">Build</button>
                </g:form>

            </div>
        </div>

    </g:if>
    <g:else>
        <div class="alert alert-info">There's no kit available. Create one before using this tool.</div>
    </g:else>

</div>

<div class="col-xs-12 col-lg-3">
    <g:render template="/downloads/dl"/>
</div>

</body>
</html>