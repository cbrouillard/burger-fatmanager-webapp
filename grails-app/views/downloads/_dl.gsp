<%@ page import="com.headbangers.fat.Release" %>

<div class="panel panel-primary">

    <g:set var="release" value="${Release.list([order: 'desc', sort: 'dateCreated', max: 1])[0]}"/>

    <div class="panel-body">
        <g:if test="${release}">

            <a href="${release.classicRomUrl}"
               class="btn btn-lg btn-success btn-block">Download "classic" ROM (with kits)</a>

            <a href="${release.emptyRomUrl}"
               class="btn btn-lg btn-success btn-block">Download "empty" ROM (without kits)</a>

            <g:if test="${release.docFrUrl}">
                <a href="${release.docFrUrl}"
                   class="btn btn-lg btn-success btn-block">Download Documentation (FR)</a>
            </g:if>

            <g:if test="${release.docEnUrl}">
                <a href="${release.docEnUrl}"
                   class="btn btn-lg btn-success btn-block">Download Documentation (EN)</a>
            </g:if>

            <hr/>
        </g:if>

        <a href="https://twitter.com/Spintr0nic"
           class="btn btn-lg btn-info btn-block">Follow news on Twitter</a>

        <hr/>

        <a href="https://github.com/cbrouillard/furiousadvancetracker/issues"
           class="btn btn-lg btn-default btn-block">Report an issue</a>
        <a href="https://github.com/cbrouillard/furiousadvancetracker"
           class="btn btn-lg btn-default btn-block">Fork the code on Github</a>

        <hr/>

        <div class="text-right">
            <small>Current version : ${release? release.fatVersion : 'n/a'}</small>
        </div>

    </div>

</div>