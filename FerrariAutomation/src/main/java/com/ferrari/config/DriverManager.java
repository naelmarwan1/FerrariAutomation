package com.ferrari.config;

import com.ferrari.constants.BrowserType;
import com.ferrari.constants.TimeoutConstants;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;

import javax.inject.Inject;
import javax.inject.Singleton;
import java.time.Duration;

/**
 * Manager class for WebDriver instances.
 */
@Log4j2
@Singleton
public class DriverManager {
    private final ConfigurationManager configManager;
    private WebDriver driver;
    
    /**
     * Constructor with ConfigurationManager dependency.
     *
     * @param configManager ConfigurationManager instance
     */
    @Inject
    public DriverManager(ConfigurationManager configManager) {
        this.configManager = configManager;
    }
    
    /**
     * Initialize the WebDriver based on configuration.
     *
     * @return WebDriver instance
     */
    public synchronized WebDriver getDriver() {
        if (driver == null) {
            initializeDriver();
        }
        return driver;
    }
    
    /**
     * Initialize the WebDriver based on the browser type configuration.
     */
    private void initializeDriver() {
        BrowserType browserType = configManager.getBrowserType();
        boolean headless = configManager.isHeadless();
        
        log.info("Initializing {} browser in {} mode", browserType, headless ? "headless" : "normal");
        
        switch (browserType) {
            case CHROME:
                initializeChromeDriver(headless);
                break;
            case EDGE:
                initializeEdgeDriver(headless);
                break;
            case FIREFOX:
            default:
                initializeFirefoxDriver(headless);
                break;
        }
        
        configureDriverTimeouts();
        log.info("WebDriver initialized successfully");
    }
    
    /**
     * Initialize ChromeDriver with options.
     *
     * @param headless whether to run in headless mode
     */
    private void initializeChromeDriver(boolean headless) {
        ChromeOptions options = new ChromeOptions();
        if (headless) {
            options.addArguments("--headless");
        }
        options.addArguments("--start-maximized");
        options.addArguments("--disable-infobars");
        options.addArguments("--disable-notifications");
        
        driver = new ChromeDriver(options);
    }
    
    /**
     * Initialize FirefoxDriver with options.
     *
     * @param headless whether to run in headless mode
     */
    private void initializeFirefoxDriver(boolean headless) {
        FirefoxOptions options = new FirefoxOptions();
        if (headless) {
            options.addArguments("-headless");
        }
        
        driver = new FirefoxDriver(options);
        driver.manage().window().maximize();
    }
    
    /**
     * Initialize EdgeDriver with options.
     *
     * @param headless whether to run in headless mode
     */
    private void initializeEdgeDriver(boolean headless) {
        EdgeOptions options = new EdgeOptions();
        if (headless) {
            options.addArguments("--headless");
        }
        options.addArguments("--start-maximized");
        
        driver = new EdgeDriver(options);
    }
    
    /**
     * Configure driver timeouts based on configuration.
     */
    private void configureDriverTimeouts() {
        driver.manage().timeouts().implicitlyWait(
                TimeoutConstants.getImplicitWaitDuration(configManager.getImplicitTimeout()));
        driver.manage().timeouts().pageLoadTimeout(
                TimeoutConstants.getPageLoadTimeout(configManager.getPageLoadTimeout()));
        driver.manage().timeouts().scriptTimeout(
                TimeoutConstants.getScriptTimeout(configManager.getScriptTimeout()));
    }
    
    /**
     * Quit the WebDriver instance.
     */
    public void quitDriver() {
        if (driver != null) {
            log.info("Closing WebDriver");
            driver.quit();
            driver = null;
        }
    }
}
