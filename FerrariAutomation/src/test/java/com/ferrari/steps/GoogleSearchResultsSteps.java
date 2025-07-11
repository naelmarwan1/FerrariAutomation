package com.ferrari.steps;

import com.ferrari.pages.GoogleSearchResultsPage;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j2;

import javax.inject.Inject;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Step definitions for Google search results page.
 */
@Log4j2
public class GoogleSearchResultsSteps {
    
    private final GoogleSearchResultsPage searchResultsPage;
    
    /**
     * Constructor with dependencies injected by Guice.
     *
     * @param searchResultsPage GoogleSearchResultsPage instance
     */
    @Inject
    public GoogleSearchResultsSteps(GoogleSearchResultsPage searchResultsPage) {
        this.searchResultsPage = searchResultsPage;
    }
    
    /**
     * Click on the first search result.
     */
    @When("I click on the first search result")
    public void iClickOnTheFirstSearchResult() {
        log.info("Clicking on the first search result");
        assertThat(searchResultsPage.isLoaded())
                .as("Search results page should be loaded")
                .isTrue();
        
        assertThat(searchResultsPage.getNumberOfResults())
                .as("Search results should be present")
                .isGreaterThan(0);
        
        searchResultsPage.clickFirstResult();
    }
}
