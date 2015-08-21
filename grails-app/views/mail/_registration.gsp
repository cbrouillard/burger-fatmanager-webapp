<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="app.name"/></title>
</head>

<body>
<img src="${resource(dir: "images", file: 'logo_mail.png', absolute: true)}"/><br/>
Welcome on board <strong>${user.username}</strong>, your registration is almost completed ! Please click the link below to activate your account!

<br/><br/>
<g:link controller="person" action="validate" absolute="true" params="[token: user.token]" id="${user.id}">
    ${createLink(controller: 'person', action: 'validate', absolute: true, params: [token: user.token], id: user.id)}
</g:link>

<hr/>
Play your music loud && FAT !<br/>

</body>
</html>