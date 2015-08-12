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

    <div class="panel panel-primary">

        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <tr>

                        <g:sortableColumn property="username"
                                          title="Username"/>

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
                            <td>
                                <g:link controller="admin" action="toggle" id="${person.id}" params="[t: 'enabled']"
                                        class="btn  btn-${person.enabled ? 'success' : 'danger'}">
                                    <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                        boolean="${person.enabled}"/>
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="admin" action="toggle" id="${person.id}" params="[t: 'accountExpired']"
                                        class="btn  btn-${person.accountExpired ? 'danger' : 'success'}">
                                    <span class="glyphicon glyphicon-option-vertical"></span> <g:formatBoolean
                                        boolean="${person.accountExpired}"/>
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="admin" action="toggle" id="${person.id}" params="[t: 'accountLocked']"
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
                                            <g:form url="[id:person.id, action: 'delete']" method="DELETE"
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
                            </td>
                        </tr>
                    </g:each>

                </table>
            </div>

        </div>
    </div>

</div>

</body>
</html>