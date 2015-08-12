package com.headbangers.fat

class Sample {

    static belongsTo = [Person]

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
