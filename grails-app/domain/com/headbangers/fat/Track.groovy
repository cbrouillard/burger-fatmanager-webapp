package com.headbangers.fat

class Track implements Comparable<Track> {

    static belongsTo = [Person, BackupFile]

    String id

    Integer index
    String name
    Long size
    byte[] data

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

    @Override
    int compareTo(Track o) {
        return this.index.compareTo(o.index)
    }
}
