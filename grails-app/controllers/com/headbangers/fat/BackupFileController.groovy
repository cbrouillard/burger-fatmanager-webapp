package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class BackupFileController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def springSecurityService
    def savFileService

    def index(Integer max) {
        def user = springSecurityService.currentUser

        params.max = Math.min(max ?: 50, 100)
        params.sort = "dateCreated"
        params.order = "desc"
        respond BackupFile.findAllByOwner(user, params),
                model: [backupFileInstanceCount: BackupFile.countByOwner(user)]
    }

    @Transactional
    def save(BackupFile backupFileInstance) {
        if (backupFileInstance == null) {
            notFound()
            return
        }

        def user = springSecurityService.currentUser

        def file
        if (params.btnsubmit?.equals("send")) {
            // checking file
            file = request.getFile("savfile")

            if (file.isEmpty() || !file.getContentType().equals("application/x-spss-sav")) {
                flash.message = "No .sav file uploaded"
                chain action: 'index'
                return
            }
        }

        backupFileInstance.owner = springSecurityService.currentUser
        backupFileInstance.validate()
        backupFileInstance.save flush: true

        // treating file
        if (params.btnsubmit?.equals("send")) {
            savFileService.treatSaveFile(file, backupFileInstance)
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'backupFile.label', default: 'BackupFile'), backupFileInstance.id])
        redirect action: 'index'
    }

    /*def edit(BackupFile backupFileInstance) {
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
    }*/

    @Transactional
    def delete(BackupFile backupFileInstance) {

        if (backupFileInstance == null || !backupFileInstance.owner.id.equals(springSecurityService.currentUser.id)) {
            notFound()
            return
        }

        backupFileInstance.delete flush: true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'BackupFile.label', default: 'BackupFile'), backupFileInstance.id])
        redirect action: "index"
    }

    @Transactional
    def deleteTrack (){
        def track = Track.findByIdAndOwner (params.id, springSecurityService.currentUser)
        if (track){
            track.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'Track.label', default: 'Track'), track.id])
        }

        chain action: 'index'
    }

    def downloadTrack (){
        def track = Track.findByIdAndOwner (params.id, springSecurityService.currentUser)
        if (track){
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"FAT_${track.name.trim()}.raw.sng\"")
            response.outputStream << track.data
            return
        }

        redirect action: 'index'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'backupFile.label', default: 'BackupFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
