package com.headbangers.fat

import grails.transaction.Transactional
import org.springframework.web.multipart.MultipartFile

@Transactional
class SoundFileService {

    def grailsApplication

    def treatSoundFile(MultipartFile file, KitFile kit, Sample sample) {

        String root = grailsApplication.config.fat.root
        String ffmpeg = grailsApplication.config.fat.ffpmeg

        // transfer
        File storageDir = new File("${root}${kit.owner.id}/kit/")
        if (!storageDir.exists()) {
            storageDir.mkdirs();
        }

        File target = new File(storageDir, sample.name)
        file.transferTo(target)

        File transformedFile = new File(storageDir, "${sample.id}.snd")

        // running ffmpeg
        Runtime runtime = Runtime.getRuntime()
        runtime.exec((String[]) ([ffmpeg, "-y", "-i", target.absolutePath, "-ac", "1", "-ar", "16000", "-f", "s8", "-acodec", "pcm_s8", transformedFile.absolutePath].toArray()));

        // deleting original
        target.delete()
    }
}
