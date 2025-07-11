package com.ferrari.utils;

import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Utility class for reading properties from config files.
 */
@Log4j2
public class PropertyReader {
    private static final Properties properties = new Properties();
    private static final String CONFIG_FILE = "config.properties";
    
    static {
        loadProperties();
    }
    
    private PropertyReader() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Load properties from the config file.
     */
    private static void loadProperties() {
        try (InputStream inputStream = PropertyReader.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
            if (inputStream != null) {
                properties.load(inputStream);
                log.info("Properties loaded successfully from {}", CONFIG_FILE);
            } else {
                log.error("Property file '{}' not found in the classpath", CONFIG_FILE);
            }
        } catch (IOException e) {
            log.error("Failed to load properties file: {}", e.getMessage(), e);
        }
    }
    
    /**
     * Get a property value by key.
     *
     * @param key the property key
     * @return the property value or null if not found
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Get a property value by key with a default value.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found
     * @return the property value or the default value if not found
     */
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * Get a property as an integer.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found or not a valid integer
     * @return the property value as an integer or the default value
     */
    public static int getIntProperty(String key, int defaultValue) {
        String value = getProperty(key);
        if (value == null) {
            return defaultValue;
        }
        
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            log.warn("Failed to parse property '{}' as integer, using default value: {}", key, defaultValue);
            return defaultValue;
        }
    }
    
    /**
     * Get a property as a boolean.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found
     * @return the property value as a boolean or the default value
     */
    public static boolean getBooleanProperty(String key, boolean defaultValue) {
        String value = getProperty(key);
        if (value == null) {
            return defaultValue;
        }
        
        return Boolean.parseBoolean(value);
    }
}
