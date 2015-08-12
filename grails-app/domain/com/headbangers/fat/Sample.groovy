package com.headbangers.fat

class Sample {

    static belongsTo = [Person]

    String id

    String name

    Person owner

    static constraints = {
        name blank: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
