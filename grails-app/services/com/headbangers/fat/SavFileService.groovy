package com.headbangers.fat

import org.springframework.transaction.annotation.Transactional
import org.springframework.web.multipart.MultipartFile
import sun.nio.fs.UnixPath

import java.nio.charset.StandardCharsets
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths

class SavFileService {

    def grailsApplication

    static transactional = true

    // nb max tracks in one save
    static int TABLE_SIZE = 16;
    static short FIRST_OFFSET = 0x50;
    static int ALLOCATION_SIZE = 20;

    @Transactional
    def treatSaveFile(MultipartFile fileFromUpload, BackupFile dbData) {

        String root = grailsApplication.config.fat.root

        // transfer
        File storageDir = new File("${root}${dbData.owner.id}/backup/")
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

        File storageDir = new File("${dbData.owner.id}/backup/")
        if (!storageDir.exists()) {
            storageDir.mkdirs();
        }

        RandomAccessFile writer = null;
        try {
            writer = new RandomAccessFile(new File(storageDir, "${dbData.id}_g.sav"), "rw");

            // ecriture de la table
            writeAllocationTable(writer, dbData)

            // ecriture des tracks
            writeTracks(writer, dbData)

        } catch (FileNotFoundException ex) {
            log.error(ex)
        } catch (IOException ex) {
            log.error(ex)
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException ex) {
                    log.error(ex)
                }
            }
        }

        // return
        File toReturn = new File(storageDir, "${dbData.id}_g.sav")
        return Files.readAllBytes(toReturn.toPath())
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

    void writeAllocationTable (RandomAccessFile file, BackupFile dbData){

        int cpt = 0;
        short offset = FIRST_OFFSET;
        dbData.tracks.each {track ->

            file.writeShort(offset);
            file.writeShort((short)track.size)

            offset += (track.data.length + 6) // L N K FF FF 5A
            cpt++
        }

        offset = cpt * 4
        while (cpt < TABLE_SIZE){
            file.writeShort(offset)
            file.writeShort(0)
            offset += 4;
            cpt++;
        }

        // firstFreeOffset will be writtent later.
        file.writeShort(0xBABA)
        cpt++;

        while (cpt < ALLOCATION_SIZE){
            file.writeShort(0xFFFF)
            file.writeShort(0xFFFF)
            cpt ++;
        }

    }

    def writeTracks (RandomAccessFile file, BackupFile dbData){

        int offset = FIRST_OFFSET
        dbData.tracks.each {track ->
            file.seek(offset)
            file.write (track.data)
            file.writeByte(0x4C)
            file.writeByte(0x4E)
            file.writeByte(0x4B)
            file.writeShort(0xFFFF)
            file.writeByte(0x5A)

            offset += (track.data.length + 6)
        }

        //
        short firstFreeOffset = offset

        // padding
        while (offset < 0xFFFF){
            file.writeShort(0xFFFF)
            offset += 2;
        }

        file.seek(TABLE_SIZE * 4)
        file.writeShort(firstFreeOffset)
    }

    def readDatas(RandomAccessFile file, ArrayList<SongEntry> songs) {
        char initOffset = 0;

        for (SongEntry entry : songs) {
            if (entry.getOffset() != initOffset) {
                file.seek(entry.getOffset());
                byte[] data = new byte[entry.getSize()];

                // todo lire avec les "FOL"
                int cpt = 0
                while (cpt < entry.getSize()){

                    byte oneByte = file.readByte()

                    boolean hasJmp = false
                    if (oneByte == 0x4C){
                        // etrange.
                        byte second = file.readByte()
                        byte third = file.readByte()
                        if (second == 0x4E && 0x4B){
                            // c'est un lien
                            short newOffset = file.readShort()
                            file.seek(newOffset + 3) // + F O L
                            hasJmp = true
                        }
                    }

                    if (!hasJmp) {
                        data[cpt] = oneByte
                        cpt++
                    }

                }

                entry.setData(data);

                log.debug "SONG DATA -----------"
                log.debug new String(data, StandardCharsets.US_ASCII)
                log.debug "---------------------"
            }
            initOffset += 4;
        }
    }
}
