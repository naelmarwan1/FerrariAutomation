package com.ferrari.config;

import com.ferrari.constants.BrowserType;
import com.ferrari.constants.TimeoutConstants;
import com.ferrari.utils.PropertyReader;
import lombok.Getter;
import lombok.extern.log4j.Log4j2;

/**
 * Class responsible for managing test configuration.
 */
@Log4j2
@Getter
public class ConfigurationManager {
    private final BrowserType browserType;
    private final boolean headless;
    private final String googleUrl;
    private final String ferrariSF90Url;
    private final String searchTerm;
    private final int implicitTimeout;
    private final int pageLoadTimeout;
    private final int scriptTimeout;
    
    /**
     * Singleton instance of ConfigurationManager.
     */
    private static ConfigurationManager instance;
    
    /**
     * Get the singleton instance of ConfigurationManager.
     *
     * @return ConfigurationManager instance
     */
    public static synchronized ConfigurationManager getInstance() {
        if (instance == null) {
            instance = new ConfigurationManager();
        }
        return instance;
    }
    
    /**
     * Private constructor to enforce singleton pattern.
     * Loads configuration from properties file.
     */
    private ConfigurationManager() {
        // Browser configuration
        this.browserType = BrowserType.fromString(PropertyReader.getProperty("browser", "firefox"));
        this.headless = PropertyReader.getBooleanProperty("headless", false);
        
        // URLs
        this.googleUrl = PropertyReader.getProperty("google.url", "https://www.google.com");
        this.ferrariSF90Url = PropertyReader.getProperty("ferrari.sf90.url", "https://www.ferrari.com/en-EN/auto/sf90-stradale");
        
        // Search parameters
        this.searchTerm = PropertyReader.getProperty("search.term", "ferrari sf90");
        
        // Timeouts
        this.implicitTimeout = PropertyReader.getIntProperty("timeout.implicit", TimeoutConstants.DEFAULT_IMPLICIT_TIMEOUT);
        this.pageLoadTimeout = PropertyReader.getIntProperty("timeout.pageLoad", TimeoutConstants.DEFAULT_PAGE_LOAD_TIMEOUT);
        this.scriptTimeout = PropertyReader.getIntProperty("timeout.script", TimeoutConstants.DEFAULT_SCRIPT_TIMEOUT);
        
        logConfiguration();
    }
    
    /**
     * Log the current configuration.
     */
    private void logConfiguration() {
        log.info("Test Configuration:");
        log.info("Browser: {}", browserType);
        log.info("Headless: {}", headless);
        log.info("Google URL: {}", googleUrl);
        log.info("Ferrari SF90 URL: {}", ferrariSF90Url);
        log.info("Search Term: {}", searchTerm);
        log.info("Implicit Timeout: {} seconds", implicitTimeout);
        log.info("Page Load Timeout: {} seconds", pageLoadTimeout);
        log.info("Script Timeout: {} seconds", scriptTimeout);
    }
}
