package com.headbangers.fat

import grails.transaction.Transactional

@Transactional
class RomBuilderService {

    def grailsApplication

    ByteArrayOutputStream build(Person user, kitsId) {

        String root = grailsApplication.config.fat.root
        String gbfs = grailsApplication.config.fat.gbfs
        String defaultRom = grailsApplication.config.fat.defaultrom

        // aller chercher les kits dans la base
        List<KitFile> kits = new ArrayList<>()
        if (kits instanceof String) {
            def kitFile = KitFile.findByIdAndOwner(kitsId, user)
            if (kitFile) kits.add(kitFile)
        } else {
            kitsId.each { kitId ->
                def kitFile = KitFile.findByIdAndOwner(kitsId, user)
                if (kitFile) kits.add(kitFile)

                // pour chaque kit, générer le .gbfs après avoir créé le 0infos
            }
        }

        if (kits.isEmpty()){
            return null
        }

        // créer le 0nbkit

        // builder la ROM.
    }
}
