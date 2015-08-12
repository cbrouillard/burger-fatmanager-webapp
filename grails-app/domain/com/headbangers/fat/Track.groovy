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

    def beforeDelete (){
        BackupFile.withNewSession {
            def files = BackupFile.createCriteria().list {
                tracks {
                    eq("id", this.id)
                }
            }
            files.each { file ->
                file.removeFromTracks(this)
                file.save(flush: true)
            }
        }
    }

    Date dateCreated
    Date lastUpdated

    @Override
    int compareTo(Track o) {
        return this.index.compareTo(o.index)
    }
}
