package com.ferrari.examples;

import com.ferrari.config.ConfigurationManager;
import com.ferrari.config.DriverManager;
import com.ferrari.pages.FerrariSF90Page;
import com.ferrari.pages.GoogleHomePage;
import com.ferrari.pages.GoogleSearchResultsPage;
import org.openqa.selenium.WebDriver;

/**
 * Example showing how to use the framework programmatically.
 * This is for demonstration purposes only. The actual tests will be run using Cucumber.
 */
public class FerrariTestExample {
    
    public static void main(String[] args) {
        // Get the configuration
        ConfigurationManager configManager = ConfigurationManager.getInstance();
        
        // Initialize the driver
        DriverManager driverManager = new DriverManager(configManager);
        WebDriver driver = driverManager.getDriver();
        
        try {
            // Initialize page objects
            GoogleHomePage googleHomePage = new GoogleHomePage(driver);
            
            // Navigate to Google
            googleHomePage.goTo(configManager.getGoogleUrl());
            
            // Search for Ferrari SF90
            GoogleSearchResultsPage searchResultsPage = googleHomePage.searchFor(configManager.getSearchTerm());
            
            // Click first result
            FerrariSF90Page ferrariSF90Page = searchResultsPage.clickFirstResult();
            
            // Validate URL
            boolean isOnCorrectPage = ferrariSF90Page.isOnCorrectPage(configManager.getFerrariSF90Url());
            System.out.println("Is on correct Ferrari SF90 page: " + isOnCorrectPage);
            
            // Alternative validation
            boolean urlContainsSF90 = ferrariSF90Page.urlContains("sf90");
            System.out.println("URL contains 'sf90': " + urlContainsSF90);
            
        } finally {
            // Clean up
            driverManager.quitDriver();
        }
    }
}
