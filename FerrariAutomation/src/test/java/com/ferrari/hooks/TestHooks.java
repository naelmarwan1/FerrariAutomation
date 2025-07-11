package com.ferrari.hooks;

import com.ferrari.config.DriverManager;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.Scenario;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

import javax.inject.Inject;

/**
 * Cucumber hooks for test setup and teardown.
 */
@Log4j2
public class TestHooks {
    
    private final DriverManager driverManager;
    private final WebDriver driver;
    
    /**
     * Constructor with dependencies injected by Guice.
     *
     * @param driverManager DriverManager instance
     * @param driver WebDriver instance
     */
    @Inject
    public TestHooks(DriverManager driverManager, WebDriver driver) {
        this.driverManager = driverManager;
        this.driver = driver;
    }
    
    /**
     * Setup method to be executed before each scenario.
     *
     * @param scenario current Cucumber scenario
     */
    @Before
    public void setUp(Scenario scenario) {
        log.info("Starting scenario: {}", scenario.getName());
    }
    
    /**
     * Teardown method to be executed after each scenario.
     *
     * @param scenario current Cucumber scenario
     */
    @After
    public void tearDown(Scenario scenario) {
        log.info("Finished scenario: {}, status: {}", scenario.getName(), scenario.getStatus());
        
        if (scenario.isFailed()) {
            log.warn("Scenario failed, taking screenshot");
            takeScreenshot(scenario);
        }
        
        // Close browser only after all scenarios are complete
        // We're using a hook with a special tag for final cleanup
    }
    
    /**
     * Final cleanup method to be executed after all scenarios.
     */
    @After("@end")
    public void finalCleanup() {
        log.info("Performing final cleanup");
        driverManager.quitDriver();
    }
    
    /**
     * Take a screenshot and attach it to the scenario.
     *
     * @param scenario current Cucumber scenario
     */
    private void takeScreenshot(Scenario scenario) {
        try {
            byte[] screenshot = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            scenario.attach(screenshot, "image/png", "Screenshot");
        } catch (Exception e) {
            log.error("Failed to take screenshot: {}", e.getMessage(), e);
        }
    }
}
