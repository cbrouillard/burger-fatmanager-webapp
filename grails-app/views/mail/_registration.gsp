<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="app.name"/></title>
</head>

<body>

Welcome on board <strong>${user.username}</strong>, your registration is almost completed ! Check your email account in order to validate your account !

<br/>
<g:link controller="person" action="validate" absolute="true" params="[token:user.token]" id="${user.id}">
${createLink(controller: 'person', action:'validate', absolute: true, params: [token:user.token], id:user.id)}
</g:link>

</body>
</html>