package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
class RomController {

    def springSecurityService
    def romBuilderService

    def index() {
        def kits = KitFile.findAllByOwner(springSecurityService.currentUser)
        render(view: 'index', model: [kits: kits])
    }

    def build() {

        // if no kit selected, get out
        if (!params.kit){
            flash.message = "Please select one or more kit. If you doesn't want to include kits, please download the default ROM."
            chain(action: 'index')
        }

        // ok we have one or more kit selected. let's go.
        romBuilderService.build (springSecurityService.currentUser, params.kit)
    }
}
