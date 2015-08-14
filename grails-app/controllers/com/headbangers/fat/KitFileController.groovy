package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class KitFileController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def springSecurityService

    def index(Integer max) {
        def user = springSecurityService.currentUser

        params.max = Math.min(max ?: 50, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        respond KitFile.findAllByOwner(user, params),
                model: [kitFileInstanceCount: KitFile.countByOwner(user)]
    }

    @Transactional
    def save(KitFile kitFileInstance) {
        if (kitFileInstance == null ) {
            notFound()
            return
        }

        kitFileInstance.owner = springSecurityService.currentUser
        kitFileInstance.validate()

        if (kitFileInstance.hasErrors()) {
            respond kitFileInstance.errors, view:'index'
            return
        }

        kitFileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'kitFile.label', default: 'KitFile'), kitFileInstance.id])
                chain action: 'index'
            }
            '*' { respond kitFileInstance, [status: CREATED] }
        }
    }

    @Transactional
    def delete(KitFile kitFileInstance) {

        if (kitFileInstance == null || !kitFileInstance.owner.id.equals(springSecurityService.currentUser.id)) {
            notFound()
            return
        }

        kitFileInstance.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'KitFile.label', default: 'KitFile'), kitFileInstance.id])
        redirect action: "index"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'kitFile.label', default: 'KitFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
