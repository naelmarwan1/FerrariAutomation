package com.ferrari.pages;

import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import javax.inject.Inject;
import java.util.List;

/**
 * Page object for Google search results page.
 */
@Log4j2
public class GoogleSearchResultsPage extends BasePage {
    
    @FindBy(css = "h3")
    private List<WebElement> searchResultTitles;
    
    /**
     * Constructor with WebDriver injection.
     *
     * @param driver WebDriver instance
     */
    @Inject
    public GoogleSearchResultsPage(WebDriver driver) {
        super(driver);
    }
    
    /**
     * Click on the first search result.
     *
     * @return FerrariSF90Page
     */
    public FerrariSF90Page clickFirstResult() {
        if (searchResultTitles.isEmpty()) {
            log.error("No search results found");
            throw new RuntimeException("No search results found");
        }
        
        log.info("Clicking on first search result: {}", searchResultTitles.get(0).getText());
        click(searchResultTitles.get(0));
        
        return new FerrariSF90Page(driver);
    }
    
    /**
     * Click on a search result by index.
     *
     * @param index result index (0-based)
     * @return FerrariSF90Page
     */
    public FerrariSF90Page clickResultByIndex(int index) {
        if (index < 0 || index >= searchResultTitles.size()) {
            log.error("Invalid search result index: {}", index);
            throw new IndexOutOfBoundsException("Invalid search result index: " + index);
        }
        
        log.info("Clicking on search result at index {}: {}", index, searchResultTitles.get(index).getText());
        click(searchResultTitles.get(index));
        
        return new FerrariSF90Page(driver);
    }
    
    /**
     * Get the number of search results.
     *
     * @return number of search results
     */
    public int getNumberOfResults() {
        return searchResultTitles.size();
    }
    
    /**
     * Check if search results page is loaded.
     *
     * @return true if loaded, false otherwise
     */
    public boolean isLoaded() {
        return !searchResultTitles.isEmpty();
    }
}
