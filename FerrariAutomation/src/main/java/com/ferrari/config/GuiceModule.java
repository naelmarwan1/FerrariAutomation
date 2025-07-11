package com.ferrari.config;

import com.ferrari.pages.BasePage;
import com.ferrari.pages.FerrariSF90Page;
import com.ferrari.pages.GoogleHomePage;
import com.ferrari.pages.GoogleSearchResultsPage;
import com.google.inject.AbstractModule;
import com.google.inject.Provides;
import com.google.inject.Scopes;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.WebDriver;

/**
 * Guice module for dependency injection configuration.
 */
@Log4j2
public class GuiceModule extends AbstractModule {

    @Override
    protected void configure() {
        log.info("Configuring Guice bindings");
        
        // Bind configuration classes
        bind(ConfigurationManager.class)
                .toInstance(ConfigurationManager.getInstance());
        
        // Bind DriverManager as singleton
        bind(DriverManager.class).in(Scopes.SINGLETON);
        
        // Bind page objects
        bind(BasePage.class);
        bind(GoogleHomePage.class);
        bind(GoogleSearchResultsPage.class);
        bind(FerrariSF90Page.class);
    }
    
    /**
     * Provider method for WebDriver instance.
     *
     * @param driverManager DriverManager instance
     * @return WebDriver instance
     */
    @Provides
    public WebDriver provideWebDriver(DriverManager driverManager) {
        log.debug("Providing WebDriver instance");
        return driverManager.getDriver();
    }
}
