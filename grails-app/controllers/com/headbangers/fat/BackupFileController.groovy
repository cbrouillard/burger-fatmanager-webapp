package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.transaction.annotation.Transactional

import static org.springframework.http.HttpStatus.*

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

        // checking file
        def file = request.getFile("savfile")

        if (!file.isEmpty() && !file.getContentType().equals("application/x-spss-sav")) {
            flash.message = "Uploaded file is not a .sav one"
            chain action: 'index'
            return
        }

        backupFileInstance.owner = springSecurityService.currentUser
        backupFileInstance.validate()
        backupFileInstance.save flush: true

        // treating file
        if (!file.isEmpty()) {
            savFileService.treatSaveFile(file, backupFileInstance)
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'backupFile.label', default: 'BackupFile'), backupFileInstance.id])
        redirect action: 'index'
    }

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
    def deleteTrack() {
        def track = Track.findByIdAndOwner(params.id, springSecurityService.currentUser)
        if (track) {
            track.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'Track.label', default: 'Track'), track.id])
        }

        redirect action: 'index'
    }

    def download() {
        def backupFile = BackupFile.findByIdAndOwner(params.id, springSecurityService.currentUser)
        if (backupFile) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"FAT_${backupFile.name ?: "backup_" + formatDate(date: backupFile.dateCreated)}.sav\"")
            response.outputStream << savFileService.recreateSavFile(backupFile)
            return
        }

        redirect action: 'index'
    }

    def downloadTrack() {
        def track = Track.findByIdAndOwner(params.id, springSecurityService.currentUser)
        if (track) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"FAT_${track.name.trim()}.raw.sng\"")
            response.outputStream << track.data
            return
        }

        redirect action: 'index'
    }

    def selectTrack() {
        def tracks = new TreeSet<Track>(Track.findAllByOwner(springSecurityService.currentUser, [sort: 'name', order: 'asc']))
        def file = BackupFile.findByIdAndOwner(params.id, springSecurityService.currentUser)

        if (!file) {
            redirect(action: 'index')
            return
        }

        render view: 'managetracks', model: [tracks: tracks, file: file]
    }

    @Transactional
    def addTrack() {
        def track = Track.findByIdAndOwner(params.id, springSecurityService.currentUser)
        def file = BackupFile.findByIdAndOwner(params.file, springSecurityService.currentUser)

        if (!track || !file) {
            return
        }

        file.addToTracks(track)
        file.save(flush: true)

        render template: 'onebackupfile', model: [file: file, hideAddAction: true, hideDeleteAction: true]
    }

    @Transactional
    def unlinkTrack() {
        def track = Track.findByIdAndOwner(params.id, springSecurityService.currentUser)
        def file = BackupFile.findByIdAndOwner(params.file, springSecurityService.currentUser)

        if (!track || !file) {
            redirect(action: 'index')
            return
        }

        file.removeFromTracks(track)
        file.save(flush: true)

        render template: 'onebackupfile', model: [file: file, hideAddAction: true, hideDeleteAction: true]
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
