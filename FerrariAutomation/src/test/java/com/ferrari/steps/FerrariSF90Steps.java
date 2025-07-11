package com.ferrari.steps;

import com.ferrari.config.ConfigurationManager;
import com.ferrari.pages.FerrariSF90Page;
import com.google.inject.Inject;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j2;

import static org.assertj.core.api.Assertions.assertThat;

/**
 * Step definitions for Ferrari SF90 page.
 */
@Log4j2
public class FerrariSF90Steps {

    private final FerrariSF90Page ferrariSF90Page;
    private final ConfigurationManager configManager;

    /**
     * Constructor with dependencies injected by Guice.
     *
     * @param ferrariSF90Page FerrariSF90Page instance
     * @param configManager   ConfigurationManager instance
     */
    @Inject
    public FerrariSF90Steps(FerrariSF90Page ferrariSF90Page, ConfigurationManager configManager) {
        this.ferrariSF90Page = ferrariSF90Page;
        this.configManager = configManager;
    }

    /**
     * Verify redirection to Ferrari SF90 page.
     */
    @Then("I should be redirected to the Ferrari SF90 official page")
    public void iShouldBeRedirectedToTheFerrariSF90OfficialPage() {
        log.info("Verifying redirection to Ferrari SF90 page");

        // Verify that page is loaded
        assertThat(ferrariSF90Page.isLoaded())
                .as("Ferrari SF90 page should be loaded")
                .isTrue();

        // Verify URL contains expected pattern
        String expectedUrl = configManager.getFerrariSF90Url();
        boolean isOnCorrectPage = ferrariSF90Page.isOnCorrectPage(expectedUrl);

        // If exact URL match fails, check for URL containing SF90
        if (!isOnCorrectPage) {
            log.info("Exact URL match failed, checking if URL contains 'sf90'");
            assertThat(ferrariSF90Page.urlContains("sf90"))
                    .as("URL should contain 'sf90'")
                    .isTrue();
        } else {
            log.info("URL matches expected URL: {}", expectedUrl);
            assertThat(isOnCorrectPage)
                    .as("Should be on Ferrari SF90 page")
                    .isTrue();
        }

        // Additional assertions can be added here
        log.info("Successfully verified navigation to Ferrari SF90 page");
    }
}
