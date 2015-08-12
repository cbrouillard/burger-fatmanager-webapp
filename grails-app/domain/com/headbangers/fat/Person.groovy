package com.headbangers.fat

class Person {

	transient springSecurityService

	String username
	String password
    String artistName
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    String token

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
        artistName blank: false, unique:true
        token blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		PersonRole.findAllByPerson(this).collect { it.role }
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

    Date dateCreated
    Date lastUpdated
}
