package com.headbangers.fat

import com.headbangers.technical.MyMultipartResolver
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
@Transactional(readOnly = true)
class KitFileController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def springSecurityService
    def soundFileService

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
        if (kitFileInstance == null) {
            notFound()
            return
        }

        kitFileInstance.owner = springSecurityService.currentUser
        kitFileInstance.validate()

        if (kitFileInstance.hasErrors()) {
            respond kitFileInstance.errors, view: 'index'
            return
        }

        kitFileInstance.save flush: true

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

        kitFileInstance.delete flush: true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'KitFile.label', default: 'KitFile'), kitFileInstance.id])
        redirect action: "index"
    }

    def selectSamples() {
        def samples = Sample.findAllByOwner(springSecurityService.currentUser, [sort: 'name', order: 'asc'])
        def file = KitFile.findByIdAndOwner(params.id, springSecurityService.currentUser)

        if (!file) {
            redirect(action: 'index')
            return
        }

        render view: 'managesamples', model: [samples: samples, file: file]
    }

    @Transactional
    def sendSample() {

        def kit = KitFile.findByIdAndOwner(params.kit, springSecurityService.currentUser)
        MultipartFile file = request.getFile("soundfile")

        if (!kit) {
            redirect(action: 'index')
            return
        }

        if (!file.isEmpty()) {

            Sample sample = new Sample()
            sample.name = file.originalFilename
            sample.owner = springSecurityService.currentUser
            sample.save(flush: true)

            // treat sound file
            soundFileService.treatSoundFile(file, kit, sample)

            kit.addToSamples(sample)
            kit.save(flush: true)

            flash.message = message(code: 'default.created.message', args: [message(code: 'sample.label', default: 'Sample'), sample.id])
            chain(action: 'selectSamples', params: [id: kit.id])
            return
        }

        redirect action: "selectSamples", params: [id: kit.id]

    }

    def downloadSample() {
        def sample = Sample.findByIdAndOwner(params.id, springSecurityService.currentUser)
        if (sample) {

            File storageDir = new File("${springSecurityService.currentUser.id}/kit/")

            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"FAT_${sample.name.trim()}.raw.snd\"")
            response.outputStream << new FileOutputStream(new File(storageDir, "${sample.id}.snd"))
            return
        }

        redirect(action: 'index')
    }

    @Transactional
    def addSample() {
        def sample = Sample.findByIdAndOwner(params.id, springSecurityService.currentUser)
        def file = KitFile.findByIdAndOwner(params.file, springSecurityService.currentUser)

        if (!sample || !file) {
            redirect(action:'index')
            return
        }

        if (request.getAttribute(MyMultipartResolver.FILE_SIZE_EXCEEDED_ERROR)) {
            render template: 'onekitfile', model: [file: file, hideAddAction: true, hideDeleteAction: true, message:"Your file is too large."]
            return
        }

        file.addToSamples(sample)
        file.save(flush: true)

        render template: 'onekitfile', model: [file: file, hideAddAction: true, hideDeleteAction: true]
    }

    @Transactional
    def unlinkSample() {
        def sample = Sample.findByIdAndOwner(params.id, springSecurityService.currentUser)
        def file = KitFile.findByIdAndOwner(params.file, springSecurityService.currentUser)

        if (!sample || !file) {
            redirect(action: 'index')
            return
        }

        file.removeFromSamples(sample)
        file.save(flush: true)

        render template: 'onekitfile', model: [file: file, hideAddAction: true, hideDeleteAction: true]
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'kitFile.label', default: 'KitFile'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
