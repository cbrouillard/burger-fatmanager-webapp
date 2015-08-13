package com.headbangers.fat



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class KitFileController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        def user = springSecurityService.currentUser

        params.max = Math.min(max ?: 50, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        respond KitFile.findAllByOwner(user, params),
                model: [kitFileInstanceCount: KitFile.countByOwner(user)]
    }

    def show(KitFile kitFileInstance) {
        respond kitFileInstance
    }

    def create() {
        respond new KitFile(params)
    }

    @Transactional
    def save(KitFile kitFileInstance) {
        if (kitFileInstance == null) {
            notFound()
            return
        }

        if (kitFileInstance.hasErrors()) {
            respond kitFileInstance.errors, view:'create'
            return
        }

        kitFileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'kitFile.label', default: 'KitFile'), kitFileInstance.id])
                redirect kitFileInstance
            }
            '*' { respond kitFileInstance, [status: CREATED] }
        }
    }

    def edit(KitFile kitFileInstance) {
        respond kitFileInstance
    }

    @Transactional
    def update(KitFile kitFileInstance) {
        if (kitFileInstance == null) {
            notFound()
            return
        }

        if (kitFileInstance.hasErrors()) {
            respond kitFileInstance.errors, view:'edit'
            return
        }

        kitFileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'KitFile.label', default: 'KitFile'), kitFileInstance.id])
                redirect kitFileInstance
            }
            '*'{ respond kitFileInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(KitFile kitFileInstance) {

        if (kitFileInstance == null) {
            notFound()
            return
        }

        kitFileInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'KitFile.label', default: 'KitFile'), kitFileInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
