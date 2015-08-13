package com.headbangers.fat

import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile

import java.nio.charset.StandardCharsets

class SavFileService {

    static transactional = true

    // nb max tracks in one save
    static int TABLE_SIZE = 16;

    @Transactional
    def treatSaveFile(MultipartFile fileFromUpload, BackupFile dbData) {

        // transfer
        File storageDir = new File("${dbData.owner.id}")
        if (!storageDir.exists()) {
            storageDir.mkdirs();
        }

        fileFromUpload.transferTo(new File(storageDir, "${dbData.id}.sav"))

        // treatment.
        // v1.0.0
        RandomAccessFile reader = null;
        try {
            // read datas
            reader = new RandomAccessFile(new File(storageDir, "${dbData.id}.sav"), "rw");

            ArrayList<SongEntry> songs = readAllocationTable(reader);
            readDatas(reader, songs);

            // save data in database
            songs.each { song ->
                //println song
                if (song.name && song.size && song.data) {
                    Track track = new Track()
                    track.data = song.data
                    track.name = song.name
                    track.index = song.index
                    track.size = song.size
                    track.owner = dbData.owner

                    track.save(flush: true)
                    dbData.addToTracks(track)
                }
            }
            dbData.save(flush: true)

        } catch (FileNotFoundException ex) {
            log.error(ex)
        } catch (IOException ex) {
            log.error(ex)
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException ex) {
                    log.error(ex)
                }
            }
        }
    }

    byte[] recreateSavFile (BackupFile dbData){

        // ecriture de la table

        // ecriture des tracks

        // padding
    }

    ArrayList<SongEntry> readAllocationTable(RandomAccessFile file) {
        ArrayList<SongEntry> songs = new ArrayList<>()

        int cpt = 0;
        while (cpt < TABLE_SIZE) {
            short offset = file.readShort();
            short size = file.readShort();

            songs.add(new SongEntry(cpt, (int) offset, (int) size));
            cpt++;
        }
        return songs
    }

    def readDatas(RandomAccessFile file, ArrayList<SongEntry> songs) {
        char initOffset = 0;

        for (SongEntry entry : songs) {
            if (entry.getOffset() != initOffset) {
                file.seek(entry.getOffset());
                byte[] data = new byte[entry.getSize()];

                // todo lire avec les "FOL"
                file.read(data);
                entry.setData(data);

                log.debug "SONG DATA -----------"
                log.debug new String(data, StandardCharsets.US_ASCII)
                log.debug "---------------------"
            }
            initOffset += 4;
        }
    }
}
