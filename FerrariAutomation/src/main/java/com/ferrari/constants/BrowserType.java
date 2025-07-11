package com.ferrari.constants;

/**
 * Enum representing the available browser types for test execution.
 */
public enum BrowserType {
    CHROME,
    FIREFOX,
    EDGE;

    /**
     * Convert a string to corresponding browser type enum.
     *
     * @param browser the browser name as string
     * @return the matching BrowserType enum
     */
    public static BrowserType fromString(String browser) {
        if (browser == null || browser.isEmpty()) {
            return FIREFOX; // Default browser
        }

        try {
            return valueOf(browser.toUpperCase());
        } catch (IllegalArgumentException e) {
            return FIREFOX; // Default to Firefox if not recognized
        }
    }
}
