package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured


class PersonController {

    def springSecurityService

    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def profile() {
        def user = springSecurityService.currentUser
        render(view: 'profile', model: [user: user])
    }

    def askregister() {

    }

    def register() {

    }

    def validatetoken() {

    }
}
