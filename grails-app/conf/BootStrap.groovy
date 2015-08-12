import com.headbangers.fat.Person
import com.headbangers.fat.PersonRole
import com.headbangers.fat.Role

class BootStrap {

    def init = { servletContext ->

        def admin = Person.findByUsername("admin@fat.com")
        if (!admin) {

            // Création de l'user admin
            admin = new Person()
            admin.accountExpired = false
            admin.accountLocked = false
            admin.enabled = true
            admin.passwordExpired = false
            admin.username = "admin@fat.com"
            admin.artistName = "fatadmin"
            admin.token = "validated"

            admin.password = "admin"
            admin.save(flush: true)

            def roleAdmin = Role.findByAuthority("ROLE_ADMIN")
            def roleUser = Role.findByAuthority("ROLE_USER")
            if (!roleAdmin) {
                // Should not happen
                roleAdmin = new Role(authority: "ROLE_ADMIN").save(flush: true)
            }
            if (!roleUser){
                roleUser = new Role(authority: "ROLE_USER").save(flush: true)
            }
            PersonRole.create(admin, roleAdmin, true)
            PersonRole.create(admin, roleUser, true)
        }
    }
    def destroy = {
    }
}
