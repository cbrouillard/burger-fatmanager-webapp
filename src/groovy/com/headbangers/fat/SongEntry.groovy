package com.headbangers.fat

/**
 * Created by cyril on 12/08/15.
 */
class SongEntry {
    private String name;
    private int index;
    private int offset;
    private int size;
    private byte[] data;

    public SongEntry(int index, int offset, int size) {
        this.offset = offset;
        this.size = size;
        this.index = index;
    }

    public String getName() {
        return name;
    }

    public int getIndex() {
        return index;
    }

    public void setData(byte[] data) {
        this.data = data;
        if (data != null) {
            char[] strName = new char[8];
            int offset = 3; // SNG
            int cpt = 0;
            int writerCpt;
            char rleCount, car;
            while (cpt < 8){
                rleCount = data[offset];
                car = data[offset+1];
                writerCpt = 0;
                while (writerCpt < rleCount){
                    strName[cpt] = car;
                    writerCpt++;
                    cpt++;
                }
                offset+=2;
            }
            this.name = new String(strName);
        } else {
            this.name = null;
        }
    }

    public byte[] getData() {
        return data;
    }

    public int getOffset() {
        return offset;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    boolean equals(o) {
        if (this.is(o)) return true
        if (getClass() != o.class) return false

        SongEntry songEntry = (SongEntry) o

        if (index != songEntry.index) return false
        if (offset != songEntry.offset) return false
        if (size != songEntry.size) return false
        if (name != songEntry.name) return false

        return true
    }

    int hashCode() {
        int result
        result = (name != null ? name.hashCode() : 0)
        result = 31 * result + index
        result = 31 * result + offset
        result = 31 * result + size
        return result
    }

    @Override
    public String toString() {
        return "SongEntry{" +
                "name='" + this.name + '\'' +
                ", index=" + index +
                ", offset=" + offset +
                ", size=" + size +
                '}';
    }
}
