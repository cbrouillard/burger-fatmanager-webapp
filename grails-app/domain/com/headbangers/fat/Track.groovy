package com.headbangers.fat

class Track {

    static belongsTo = [Person, BackupFile]

    String id

    String name
    Long size

    Person owner

    static constraints = {
        name nullable:false, blank: false
        size nullable: true
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
