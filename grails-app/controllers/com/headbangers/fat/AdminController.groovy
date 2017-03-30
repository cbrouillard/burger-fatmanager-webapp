package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.transaction.annotation.Transactional

import static org.springframework.http.HttpStatus.NO_CONTENT

@Secured(['ROLE_ADMIN'])
class AdminController {

    def console(Integer max) {
        params.max = Math.min(max ?: 50, 100)
        def users = Person.list(params)

        def lastRelease = Release.list([order: 'desc', sort: 'dateCreated', max: 1])

        render(view: 'console', model: [users: users, usersTotal: users.totalCount,release: (lastRelease ? lastRelease.get(0) : null)])
    }

    @Transactional
    def release() {

        Release release = new Release(params)
        release.validate()
        release.save(flush: true)
        redirect(action: 'console')

    }

    @Transactional
    def toggle() {
        Person person = Person.get(params.id)
        if (person) {
            person.properties[params.t] = !person.properties[params.t]
            person.save(flush: true)
        }
        redirect(action: 'console')
        return
    }

    @Transactional
    def delete(Person personInstance) {

        if (personInstance == null) {
            redirect(action: 'console')
            return
        }

        PersonRole.removeAll(personInstance, true)
        personInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Person.label', default: 'Person'), personInstance.username])
                redirect action: "console", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    def resendMailRegistration() {
        def person = Person.get(params.id)
        if (person) {
            sendMail {
                async true
                to person.username
                from "noreply@furiousadvancetracker.com"
                subject '[FAT] Welcome onboard !'
                html g.render(template: "/mail/registration", model: [user: person])
            }

            flash.message = "Message sent"
        }
        chain(action: 'console')
    }
}
