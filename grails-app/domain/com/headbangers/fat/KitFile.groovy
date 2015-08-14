package com.headbangers.fat

class KitFile {

    static belongsTo = [Person]
    static hasMany = [samples: Sample]

    String id

    String name
    Boolean shared = false

    Person owner

    static constraints = {
        name blank: false
        shared nullable: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
