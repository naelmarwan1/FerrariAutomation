package com.ferrari.pages;

import com.ferrari.utils.WaitUtils;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import javax.inject.Inject;

/**
 * Base page class that all page objects extend.
 */
@Log4j2
public abstract class BasePage {
    protected final WebDriver driver;
    
    /**
     * Constructor for base page with WebDriver injection.
     *
     * @param driver WebDriver instance
     */
    @Inject
    public BasePage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        log.debug("Initialized {}", this.getClass().getSimpleName());
    }
    
    /**
     * Navigate to a URL.
     *
     * @param url URL to navigate to
     */
    public void navigateTo(String url) {
        log.info("Navigating to: {}", url);
        driver.navigate().to(url);
        WaitUtils.waitForPageLoad(driver);
    }
    
    /**
     * Get the current URL.
     *
     * @return current URL
     */
    public String getCurrentUrl() {
        return driver.getCurrentUrl();
    }
    
    /**
     * Click on an element with explicit wait.
     *
     * @param element WebElement to click
     */
    protected void click(WebElement element) {
        log.debug("Clicking element: {}", element);
        WaitUtils.waitForElementClickable(driver, element).click();
    }
    
    /**
     * Enter text into an element with explicit wait.
     *
     * @param element WebElement to enter text into
     * @param text text to enter
     */
    protected void sendKeys(WebElement element, String text) {
        log.debug("Sending text to element: {}", element);
        WaitUtils.waitForElementVisible(driver, element).sendKeys(text);
    }
    
    /**
     * Check if an element is displayed with explicit wait.
     *
     * @param element WebElement to check
     * @return true if element is displayed, false otherwise
     */
    protected boolean isElementDisplayed(WebElement element) {
        try {
            return WaitUtils.waitForElementVisible(driver, element).isDisplayed();
        } catch (Exception e) {
            log.debug("Element is not displayed: {}", element);
            return false;
        }
    }
    
    /**
     * Get text from an element with explicit wait.
     *
     * @param element WebElement to get text from
     * @return text of the element
     */
    protected String getText(WebElement element) {
        return WaitUtils.waitForElementVisible(driver, element).getText();
    }
    
    /**
     * Execute JavaScript.
     *
     * @param script JavaScript to execute
     * @param args arguments to pass to script
     * @return result of script execution
     */
    protected Object executeJavaScript(String script, Object... args) {
        log.debug("Executing JavaScript: {}", script);
        return ((JavascriptExecutor) driver).executeScript(script, args);
    }
}
