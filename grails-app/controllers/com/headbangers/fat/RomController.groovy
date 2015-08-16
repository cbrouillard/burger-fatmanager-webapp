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

        def rom = romBuilderService.build (springSecurityService.currentUser, params.kit)

        if (rom) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"FAT_${springSecurityService.currentUser.artistName.replaceAll(' ', '_')}.gba\"")
            response.outputStream << rom
            return
        }

        flash.message = "There was a problem during generation. Sorry about that :("
        chain action: "index"
    }
}
