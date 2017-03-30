package com.headbangers.fat

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.transaction.annotation.Transactional

import com.megatome.grails.RecaptchaService

import static org.springframework.http.HttpStatus.OK


class PersonController {

    def springSecurityService

    RecaptchaService recaptchaService

    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def profile() {
        def user = springSecurityService.currentUser
        render(view: 'profile', model: [user: user])
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def saveprofile() {
        Person user = springSecurityService.currentUser

        def pass = params.password
        def confirmation = params.passwordCheck

        if (pass) {
            if (pass != confirmation) {
                // should not happen
                flash.message = "Password error"
                chain action: 'profile'
                return
            }
            user.password = pass
        }

        user.artistName = params.artistName
        user.validate()
        if (user.hasErrors()) {
            flash.message = "Invalid action"
            render view: 'profile', model: [user: user]
            return
        }

        user.save flush: true
        flash.message = "Profile updated"
        chain(action: "profile")
        return
    }

    // public
    def askregister() {
        def user = new Person()
        render(view: 'askregister', model: [user: user])
    }

    // public
    @Transactional
    def register(Person personInstance) {
        if (personInstance == null) {
            redirect(controller: 'login')
            return
        }

        if (params.passwordNew && params.passwordCheck && params.passwordNew == params.passwordCheck) {
            personInstance.password = params.passwordNew
        }
        personInstance.token = UUID.randomUUID().toString();

        def recaptchaOK = false
        if (recaptchaService.verifyAnswer(session, request.getRemoteAddr(), params)) {
          recaptchaOK = true
        }

        personInstance.validate()
        if (personInstance.hasErrors() || !recaptchaOK) {
            render view: 'askregister', model: [user: personInstance]
            return
        }

        personInstance.enabled = false
        personInstance.save(flush: true)

        Role role = Role.findByAuthority("ROLE_USER")
        PersonRole.create(personInstance, role, true)

        sendMail {
            async true
            to personInstance.username
            from "noreply@furiousadvancetracker.com"
            subject '[FAT] Welcome onboard !'
            html g.render(template: "/mail/registration", model: [user: personInstance])
        }

        request.withFormat {
            form multipartForm {
                flash.message = "Check your mail ! A validation token has been sent to you."
                chain(controller: 'login', action: 'auth')
            }
            '*' { respond personInstance, [status: OK] }
        }
    }

// public
    def validate() {
        Person person = Person.get(params.id)
        if (person && person.token == params.token) {
            person.enabled = true
            person.save(flush: true)

            flash.message = "The registration is over ! You can now log in."
            chain(controller: 'login', action: 'auth')
            return
        }

        redirect(controller: 'login')
        return
    }

}
