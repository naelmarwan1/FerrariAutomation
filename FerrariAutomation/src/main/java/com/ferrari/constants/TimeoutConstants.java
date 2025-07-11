package com.ferrari.constants;

import java.time.Duration;

/**
 * Constants for various timeouts used in the test framework.
 */
public final class TimeoutConstants {
    private TimeoutConstants() {
        // Private constructor to prevent instantiation
    }

    // Default timeout values in seconds
    public static final int DEFAULT_IMPLICIT_TIMEOUT = 10;
    public static final int DEFAULT_PAGE_LOAD_TIMEOUT = 30;
    public static final int DEFAULT_SCRIPT_TIMEOUT = 30;
    
    // Convert to Duration objects for Selenium usage
    public static Duration getImplicitWaitDuration(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    public static Duration getPageLoadTimeout(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    public static Duration getScriptTimeout(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    // Explicit wait constants
    public static final Duration SHORT_WAIT = Duration.ofSeconds(5);
    public static final Duration MEDIUM_WAIT = Duration.ofSeconds(10);
    public static final Duration LONG_WAIT = Duration.ofSeconds(30);
}
