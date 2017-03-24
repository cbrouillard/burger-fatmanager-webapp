
def ENV_NAME = "FAT_CONF"
def props = new Properties()
String home = System.getProperty("user.home");
String confFilePath = home+ "/.fat.properties"
if(System.getenv(ENV_NAME)) {
    confFilePath = System.getenv(ENV_NAME);
}

try {
    InputStream is
    File confFile = new File (confFilePath)
    if (!confFile.exists()){
        is = getClass().getClassLoader().getResourceAsStream("classpath:fat.properties")
    } else{
        is = new FileInputStream(confFilePath)
    }

    props.load(new BufferedInputStream(is))
    is.close()
} catch (Exception e){
    println "FATAL ERROR : fat.properties does not exist or FAT_CONF env has not been defined."
}

dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            driverClassName = props.get("datasource.driverClassName")
            username = props.get("datasource.username")
            password = props.get("datasource.password")
            dbCreate = props.get("datasource.dbCreate")
            url = props.get("datasource.url")

        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
        dataSource {
            driverClassName = props.get("datasource.driverClassName")
            username = props.get("datasource.username")
            password = props.get("datasource.password")
            dbCreate = props.get("datasource.dbCreate")
            url = props.get("datasource.url")

        }
    }
}
