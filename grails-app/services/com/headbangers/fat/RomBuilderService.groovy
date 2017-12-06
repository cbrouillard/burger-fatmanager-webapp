package com.headbangers.fat

import grails.transaction.Transactional

@Transactional
class RomBuilderService {

    def grailsApplication

    FileInputStream build(Person user, kitsId) {

        String root = grailsApplication.config.fat.root
        String gbfs = grailsApplication.config.fat.createGBFS
        String buildRom = grailsApplication.config.fat.buildRom
        String cleanAfterBuild = grailsApplication.config.fat.cleanAfterBuild

        // aller chercher les kits dans la base
        List<KitFile> kits = new ArrayList<>()
        if (kitsId instanceof String) {
            def kitFile = KitFile.findByIdAndOwner(kitsId, user)
            if (kitFile) {
                kits.add(kitFile)
            }
        } else {
            kitsId.each { kitId ->
                def kitFile = KitFile.findByIdAndOwner(kitId, user)
                if (kitFile) {
                    kits.add(kitFile)
                }

            }

        }

        if (kits.isEmpty()) {
            return null
        }

        kits.each { kit ->
            // générer le gbfs
            File workingDirectory = new File("${root}${user.id}/kit/${kit.id}")
            if (!workingDirectory.exists()) {
                workingDirectory.mkdirs()
            }

            List<String> params = new ArrayList<>()
            params.add(gbfs)
            params.add("${root}${user.id}/kit/${kit.id}/${kit.id}.gbfs")

            File infosFile = new File(workingDirectory, "00infos")
            FileWriter infos = new FileWriter(infosFile)
            infos.write("${kit.name.length() >= 8 ? kit.name.substring(0, 8) : String.format('%1$-8s', kit.name)} packaged on FuriousAdvanceTracker.com")
            infos.close()
            params.add(infosFile.absolutePath)

            kit.samples.each { sample ->
                params.add("${root}${user.id}/kit/${sample.id}.snd")
            }

            log.debug "GBFS"
            log.debug "----------"
            log.debug params
            log.debug "----------"

            println params

            // execution gbfs
            Runtime runtime = Runtime.getRuntime()
            Process process = runtime.exec((String[]) (params.toArray()));
            process.waitFor()
        }

        // créer le 0nbkit
        List<String> rombuildParams = new ArrayList<>()
        rombuildParams.add(buildRom)
        rombuildParams.add("${root}${user.id}/FAT_${user.artistName.replaceAll(' ', '_')}.gba")

        int nbKit = 0
        List<String> validKitGbfs = new ArrayList<>()
        kits.each { kit ->
            File kitGbfs = new File ("${root}${user.id}/kit/${kit.id}/${kit.id}.gbfs")
            if (kitGbfs.exists()){
                validKitGbfs.add(kitGbfs.absolutePath)
                nbKit ++
            }
        }
        File nbKitFile = new File ("${root}${user.id}/kit/00nbkit")
        FileWriter writerNbKit = new FileWriter(nbKitFile)
        writerNbKit.write(""+nbKit)
        writerNbKit.close()
        rombuildParams.add(nbKitFile.absolutePath)

        rombuildParams.add(user.id)
        rombuildParams.addAll(validKitGbfs)

        // builder la ROM.
        log.debug "ROM"
        log.debug "----------"
        log.debug rombuildParams
        log.debug "----------"
        println rombuildParams
        Runtime runtime = Runtime.getRuntime()
        Process build = runtime.exec((String[]) (rombuildParams.toArray()));
        build.waitFor()

        return new FileInputStream(new File("${root}${user.id}/FAT_${user.artistName.replaceAll(' ', '_')}.gba"))
    }
}
