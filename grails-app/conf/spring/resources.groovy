import javax.servlet.MultipartConfigElement

// Place your Spring DSL code here
beans = {
    multipartResolver(com.headbangers.technical.MyMultipartResolver){
        maxInMemorySize=1024000
        maxUploadSize=102400
        //uploadTempDir="/tmp"
    }
}