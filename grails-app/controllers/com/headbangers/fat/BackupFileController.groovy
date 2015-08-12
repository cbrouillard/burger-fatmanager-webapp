package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class BackupFileController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def springSecurityService

    def index(Integer max) {
        def user = springSecurityService.currentUser

        params.max = Math.min(max ?: 50, 100)
        respond BackupFile.findAllByOwner(user, params),
                model:[backupFileInstanceCount: BackupFile.countByOwner(user)]
    }

    def show(BackupFile backupFileInstance) {
        respond backupFileInstance
    }

    def create() {
        respond new BackupFile(params)
    }

    @Transactional
    def save(BackupFile backupFileInstance) {
        if (backupFileInstance == null) {
            notFound()
            return
        }

        if (backupFileInstance.hasErrors()) {
            respond backupFileInstance.errors, view:'create'
            return
        }

        backupFileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'backupFile.label', default: 'BackupFile'), backupFileInstance.id])
                redirect backupFileInstance
            }
            '*' { respond backupFileInstance, [status: CREATED] }
        }
    }

    def edit(BackupFile backupFileInstance) {
        respond backupFileInstance
    }

    @Transactional
    def update(BackupFile backupFileInstance) {
        if (backupFileInstance == null) {
            notFound()
            return
        }

        if (backupFileInstance.hasErrors()) {
            respond backupFileInstance.errors, view:'edit'
            return
        }

        backupFileInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BackupFile.label', default: 'BackupFile'), backupFileInstance.id])
                redirect backupFileInstance
            }
            '*'{ respond backupFileInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BackupFile backupFileInstance) {

        if (backupFileInstance == null || !backupFileInstance.owner.id.equals(springSecurityService.currentUser.id)) {
            notFound()
            return
        }

        backupFileInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BackupFile.label', default: 'BackupFile'), backupFileInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'backupFile.label', default: 'BackupFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
