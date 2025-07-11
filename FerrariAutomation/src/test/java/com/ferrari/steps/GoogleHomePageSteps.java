package com.ferrari.steps;

import com.ferrari.config.ConfigurationManager;
import com.ferrari.pages.GoogleHomePage;
import com.google.inject.Inject;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j2;


import static org.assertj.core.api.Assertions.assertThat;

/**
 * Step definitions for Google home page.
 */
@Log4j2
public class GoogleHomePageSteps {
    
    private final GoogleHomePage googleHomePage;
    private final ConfigurationManager configManager;
    
    /**
     * Constructor with dependencies injected by Guice.
     *
     * @param googleHomePage GoogleHomePage instance
     * @param configManager ConfigurationManager instance
     */
    @Inject
    public GoogleHomePageSteps(GoogleHomePage googleHomePage, ConfigurationManager configManager) {
        this.googleHomePage = googleHomePage;
        this.configManager = configManager;
    }
    
    /**
     * Navigate to Google homepage.
     */
    @Given("I am on the Google homepage")
    public void iAmOnTheGoogleHomepage() {
        log.info("Navigating to Google homepage");
        googleHomePage.goTo(configManager.getGoogleUrl());
        assertThat(googleHomePage.isLoaded())
                .as("Google homepage should be loaded")
                .isTrue();
    }
    
    /**
     * Search for a term.
     *
     * @param searchTerm term to search for
     */
    @When("I search for {string}")
    public void iSearchFor(String searchTerm) {
        log.info("Searching for: {}", searchTerm);
        googleHomePage.searchFor(searchTerm);
    }
}
