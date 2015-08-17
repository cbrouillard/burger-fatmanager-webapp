import javax.servlet.MultipartConfigElement

// Place your Spring DSL code here
beans = {
    multipartResolver(org.springframework.web.multipart.commons.CommonsMultipartResolver){
        maxInMemorySize=10240000
        maxUploadSize=10240000
        //uploadTempDir="/tmp"
    }
}