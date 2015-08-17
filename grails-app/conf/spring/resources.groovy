import javax.servlet.MultipartConfigElement

// Place your Spring DSL code here
beans = {
    multipartResolver(org.springframework.web.multipart.commons.CommonsMultipartResolver){
        maxInMemorySize=1024000
        maxUploadSize=102400
        //uploadTempDir="/tmp"
    }
}