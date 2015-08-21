<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div class="col-xs-12 col-lg-8 col-lg-offset-2">
    <div class="page-title">Administration console</div>
</div>

<div class="col-xs-12 col-lg-8 col-lg-offset-2">

    <g:if test="${flash.message}">
        <div class="alert alert-info" role="status">${flash.message}</div>
    </g:if>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#users" role="tab" data-toggle="tab">Users</a></li>
        <li role="presentation"><a href="#releases" role="tab" data-toggle="tab">Releases</a></li>
    </ul>

    <div class="tab-content responsive">

        <div role="tabpanel" class="tab-pane active" id="users">
            <div class="panel panel-primary panel-in-tab">
                <div class="panel-heading panel-in-tab">&nbsp;</div>

                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <tr>

                                <g:sortableColumn property="username"
                                                  title="Username"/>

                                <g:sortableColumn property="artistName"
                                                  title="Artist name"/>

                                <g:sortableColumn property="enabled"
                                                  title="Enabled"/>

                                <g:sortableColumn property="accountExpired"
                                                  title="Account Expired"/>

                                <g:sortableColumn property="accountLocked"
                                                  title="Account Locked"/>

                                <g:sortableColumn property="passwordExpired"
                                                  title="Password Expired"/>

                                <g:sortableColumn property="dateCreated"
                                                  title="Date Created"/>

                                <td>&nbsp;</td>

                            </tr>

                            <g:each in="${users}" var="person">
                                <tr>
                                    <td>${person.username}</td>
                                    <td>${person.artistName}</td>
                                    <td>
                                        <g:link controller="admin" action="toggle" id="${person.id}"
                                                params="[t: 'enabled']"
                                                class="btn  btn-${person.enabled ? 'success' : 'danger'}">
                                            <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                                boolean="${person.enabled}"/>
                                        </g:link>
                                    </td>
                                    <td>
                                        <g:link controller="admin" action="toggle" id="${person.id}"
                                                params="[t: 'accountExpired']"
                                                class="btn  btn-${person.accountExpired ? 'danger' : 'success'}">
                                            <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                                boolean="${person.accountExpired}"/>
                                        </g:link>
                                    </td>
                                    <td>
                                        <g:link controller="admin" action="toggle" id="${person.id}"
                                                params="[t: 'accountLocked']"
                                                class="btn  btn-${person.accountLocked ? 'danger' : 'success'}">
                                            <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                                boolean="${person.accountLocked}"/>
                                        </g:link>
                                    </td>
                                    <td>
                                        <g:link controller="admin" action="toggle" id="${person.id}"
                                                params="[t: 'passwordExpired']"
                                                class="btn  btn-${person.passwordExpired ? 'danger' : 'success'}">
                                            <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                                boolean="${person.passwordExpired}"/>
                                        </g:link>
                                    </td>
                                    <td><g:formatDate date="${person.dateCreated}"/></td>
                                    <td>
                                        <g:if test="${sec.loggedInUserInfo(field: "username") != person.username}">
                                            <sec:ifAllGranted roles='ROLE_ADMIN'>
                                                <div class="btn-group">
                                                    <g:form url="[id: person.id, action: 'delete']" method="DELETE"
                                                            class="form-inline pull-right">&nbsp;
                                                        <button type="submit" class="btn btn-danger "
                                                                onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                                            <span class="glyphicon glyphicon-remove"></span>
                                                        </button>

                                                    </g:form>
                                                    <form action='${request.contextPath}/j_spring_security_switch_user'
                                                          method='POST' class="form-inline pull-right">
                                                        <g:hiddenField name="j_username" value="${person.username}"/>
                                                        <button type="submit" class="btn  btn-danger">
                                                            <span class="glyphicon glyphicon-user"></span> ${message(code: 'default.button.switch.label', default: 'Switch')}
                                                        </button>
                                                    </form>

                                                </div>

                                            </sec:ifAllGranted>
                                        </g:if>

                                        <g:if test="${!person.enabled}">
                                            <g:link controller="admin" action="resendMailRegistration" id="${person.id}"
                                                    class="btn btn-default">Resend reg mail</g:link>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>

                        </table>
                    </div>

                </div>
            </div>
        </div>

        <div role="tabpanel" class="tab-pane" id="releases">
            <div class="panel panel-primary panel-in-tab">
                <div class="panel-heading panel-in-tab">&nbsp;</div>

                <div class="panel-body">

                    <g:form controller="admin" action="release" method="post"  data-toggle="validator">
                        <div class="form-group">
                            <label for="fatVersion">Release version</label>
                            <input type="text" class="form-control" id="fatVersion" name="fatVersion" placeholder="The fat release's version, ie : 1.0.0 (rc1)"
                                   value="${release?.fatVersion}" required="">
                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                            <label for="classicRomUrl">Link for "classic" ROM download</label>
                            <input type="url" class="form-control" id="classicRomUrl" name="classicRomUrl" placeholder="HTTP Url to classic ROM"
                                   value="${release?.classicRomUrl}" required="">
                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                            <label for="emptyRomUrl">Link for "empty" ROM download</label>
                            <input type="url" class="form-control" id="emptyRomUrl" name="emptyRomUrl" placeholder="HTTP Url to empty ROM"
                                   value="${release?.emptyRomUrl}" required="">
                            <div class="help-block with-errors"></div>
                        </div>

                        <div class="form-group">
                            <label for="docFrUrl">Link for FR documentation</label>
                            <input type="url" class="form-control" id="docFrUrl" name="docFrUrl" placeholder="HTTP Url to FR doc"
                                   value="${release?.docFrUrl}">
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <label for="docEnUrl">Link for EN documentation</label>
                            <input type="url" class="form-control" id="docEnUrl" name="docEnUrl" placeholder="HTTP Url to EN doc"
                                   value="${release?.docEnUrl}">
                            <div class="help-block with-errors"></div>
                        </div>

                        <hr/>
                        <button type="submit" class="btn btn-default pull-right">Save</button>
                    </g:form>

                </div>

            </div>
        </div>
    </div>
</div>

</div>

</body>
</html>