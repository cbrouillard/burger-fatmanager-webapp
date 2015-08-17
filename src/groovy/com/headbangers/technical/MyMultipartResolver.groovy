package com.headbangers.technical

import org.springframework.util.LinkedMultiValueMap
import org.springframework.util.MultiValueMap
import org.springframework.web.multipart.MaxUploadSizeExceededException
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartResolver
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest
import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest

import javax.servlet.http.HttpServletRequest

/**
 * Created by cyril on 17/08/15.
 */
class MyMultipartResolver extends CommonsMultipartResolver {

    static final String FILE_SIZE_EXCEEDED_ERROR = "fileSizeExceeded"

    @Override
    public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) {

        try {
            return super.resolveMultipart(request)
        }
        catch (MaxUploadSizeExceededException maxUploadSizeExceededException) {
            request.setAttribute(FILE_SIZE_EXCEEDED_ERROR, true)
            return new StandardMultipartHttpServletRequest (request)
            //return new DefaultMultipartHttpServletRequest(request, new LinkedMultiValueMap<String, MultipartFile>(), [:], [:])
        }
    }
}