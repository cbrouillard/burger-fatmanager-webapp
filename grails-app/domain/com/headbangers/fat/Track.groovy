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
        name nullable: false, blank: false
        size nullable: true
    }

    static mapping = {
        id generator: 'uuid'
    }

    def beforeDelete() {
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
        def compare = this.index.compareTo(o.index)
        if (!compare) {
            compare = this.name.compareTo(o.name)
        }
        return compare
    }

    boolean equals(o) {
        if (this.is(o)) return true
        if (getClass() != o.class) return false

        Track track = (Track) o

        if (name != track.name) return false
        if (owner != track.owner) return false
        if (size != track.size) return false

        return true
    }

    int hashCode() {
        int result
        result = (name != null ? name.hashCode() : 0)
        result = 31 * result + (size != null ? size.hashCode() : 0)
        result = 31 * result + (owner != null ? owner.hashCode() : 0)
        return result
    }
}
