package com.headbangers.fat

class BackupFile {

    static belongsTo = [Person]
    static hasMany = [tracks: Track]

    String id

    String name

    Person owner
    SortedSet<Track> tracks

    static constraints = {
        name nullable: true, blank: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
