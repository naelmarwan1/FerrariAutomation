package com.ferrari.pages;

import com.ferrari.utils.WaitUtils;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import javax.inject.Inject;
import java.time.Duration;

/**
 * Page object for Ferrari SF90 page.
 */
@Log4j2
public class FerrariSF90Page extends BasePage {
    
    @FindBy(css = ".model_banner")
    private WebElement modelBanner;
    
    @FindBy(css = ".model-name")
    private WebElement modelName;
    
    /**
     * Constructor with WebDriver injection.
     *
     * @param driver WebDriver instance
     */
    @Inject
    public FerrariSF90Page(WebDriver driver) {
        super(driver);
    }
    
    /**
     * Check if page URL matches expected URL.
     *
     * @param expectedUrl expected URL
     * @return true if URL matches, false otherwise
     */
    public boolean isOnCorrectPage(String expectedUrl) {
        log.info("Checking if current URL matches expected URL");
        log.info("Current URL: {}", getCurrentUrl());
        log.info("Expected URL: {}", expectedUrl);
        
        try {
            WaitUtils.waitForUrlToBe(driver, expectedUrl, Duration.ofSeconds(10));
            return true;
        } catch (Exception e) {
            log.warn("URL does not match expected URL: {}", e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if page URL contains expected text.
     *
     * @param urlText expected text in URL
     * @return true if URL contains text, false otherwise
     */
    public boolean urlContains(String urlText) {
        log.info("Checking if current URL contains: {}", urlText);
        log.info("Current URL: {}", getCurrentUrl());
        
        try {
            WaitUtils.waitForUrlToContain(driver, urlText, Duration.ofSeconds(10));
            return true;
        } catch (Exception e) {
            log.warn("URL does not contain expected text: {}", e.getMessage());
            return false;
        }
    }
    
    /**
     * Check if Ferrari SF90 page is loaded.
     *
     * @return true if loaded, false otherwise
     */
    public boolean isLoaded() {
        return isElementDisplayed(modelBanner);
    }
    
    /**
     * Get the model name.
     *
     * @return model name text
     */
    public String getModelName() {
        return getText(modelName);
    }
}
