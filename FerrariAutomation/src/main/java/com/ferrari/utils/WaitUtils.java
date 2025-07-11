package com.ferrari.utils;

import com.ferrari.constants.TimeoutConstants;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

/**
 * Utility class for Selenium wait operations.
 */
@Log4j2
public class WaitUtils {
    
    private WaitUtils() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Wait for an element to be visible.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @param timeout Wait timeout duration
     * @return WebElement once it becomes visible
     */
    public static WebElement waitForElementVisible(WebDriver driver, WebElement element, Duration timeout) {
        log.debug("Waiting for element to be visible with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.visibilityOf(element));
    }
    
    /**
     * Wait for an element to be visible with default medium timeout.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @return WebElement once it becomes visible
     */
    public static WebElement waitForElementVisible(WebDriver driver, WebElement element) {
        return waitForElementVisible(driver, element, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for an element to be clickable.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @param timeout Wait timeout duration
     * @return WebElement once it becomes clickable
     */
    public static WebElement waitForElementClickable(WebDriver driver, WebElement element, Duration timeout) {
        log.debug("Waiting for element to be clickable with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.elementToBeClickable(element));
    }
    
    /**
     * Wait for an element to be clickable with default medium timeout.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @return WebElement once it becomes clickable
     */
    public static WebElement waitForElementClickable(WebDriver driver, WebElement element) {
        return waitForElementClickable(driver, element, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for the page to be fully loaded.
     *
     * @param driver WebDriver instance
     * @param timeout Wait timeout duration
     */
    public static void waitForPageLoad(WebDriver driver, Duration timeout) {
        log.debug("Waiting for page to load with timeout: {}", timeout);
        new WebDriverWait(driver, timeout).until(
                driver1 -> ((JavascriptExecutor) driver1)
                        .executeScript("return document.readyState").equals("complete"));
    }
    
    /**
     * Wait for the page to be fully loaded with default timeout.
     *
     * @param driver WebDriver instance
     */
    public static void waitForPageLoad(WebDriver driver) {
        waitForPageLoad(driver, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for a URL to contain a specific text.
     *
     * @param driver WebDriver instance
     * @param urlText Text that the URL should contain
     * @param timeout Wait timeout duration
     */
    public static void waitForUrlToContain(WebDriver driver, String urlText, Duration timeout) {
        log.debug("Waiting for URL to contain '{}' with timeout: {}", urlText, timeout);
        new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.urlContains(urlText));
    }
    
    /**
     * Wait for a URL to be exactly as specified.
     *
     * @param driver WebDriver instance
     * @param url Expected URL
     * @param timeout Wait timeout duration
     */
    public static void waitForUrlToBe(WebDriver driver, String url, Duration timeout) {
        log.debug("Waiting for URL to be '{}' with timeout: {}", url, timeout);
        new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.urlToBe(url));
    }
    
    /**
     * Wait for a custom condition.
     *
     * @param driver WebDriver instance
     * @param condition Custom ExpectedCondition
     * @param timeout Wait timeout duration
     * @param <T> Type of the expected result
     * @return Result of the condition
     */
    public static <T> T waitFor(WebDriver driver, ExpectedCondition<T> condition, Duration timeout) {
        log.debug("Waiting for custom condition with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout).until(condition);
    }
}
