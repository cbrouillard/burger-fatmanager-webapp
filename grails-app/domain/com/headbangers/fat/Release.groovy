package com.headbangers.fat

class Release {

    String fatVersion
    String classicRomUrl
    String emptyRomUrl
    String docFrUrl
    String docEnUrl

    Date dateCreated

    static constraints = {
        docFrUrl nullable: true, blank:false
        docEnUrl nullable: true, blank:false
    }
}
