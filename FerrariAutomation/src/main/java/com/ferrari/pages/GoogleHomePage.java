package com.ferrari.pages;

import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import javax.inject.Inject;

/**
 * Page object for Google home page.
 */
@Log4j2
public class GoogleHomePage extends BasePage {
    
    @FindBy(name = "q")
    private WebElement searchInput;
    
    @FindBy(name = "btnK")
    private WebElement searchButton;
    
    /**
     * Constructor with WebDriver injection.
     *
     * @param driver WebDriver instance
     */
    @Inject
    public GoogleHomePage(WebDriver driver) {
        super(driver);
    }
    
    /**
     * Navigate to Google home page.
     *
     * @param url Google URL
     * @return this page object
     */
    public GoogleHomePage goTo(String url) {
        log.info("Navigating to Google home page: {}", url);
        navigateTo(url);
        return this;
    }
    
    /**
     * Search for a term.
     *
     * @param searchTerm term to search for
     * @return GoogleSearchResultsPage
     */
    public GoogleSearchResultsPage searchFor(String searchTerm) {
        log.info("Searching for: {}", searchTerm);
        sendKeys(searchInput, searchTerm);
        
        try {
            click(searchButton);
        } catch (Exception e) {
            log.debug("Search button not clickable, using keyboard Enter instead");
            searchInput.sendKeys(Keys.ENTER);
        }
        
        return new GoogleSearchResultsPage(driver);
    }
    
    /**
     * Check if Google homepage is loaded.
     *
     * @return true if loaded, false otherwise
     */
    public boolean isLoaded() {
        return isElementDisplayed(searchInput);
    }
}
