#!/bin/bash

# Script to generate Ferrari Automation Framework project structure
# For Linux/macOS

# Set the root directory name
ROOT_DIR="FerrariAutomation"

# Create root directory
mkdir -p $ROOT_DIR
cd $ROOT_DIR

# Create Maven project structure
mkdir -p src/main/java/com/ferrari/config
mkdir -p src/main/java/com/ferrari/constants
mkdir -p src/main/java/com/ferrari/pages
mkdir -p src/main/java/com/ferrari/utils
mkdir -p src/main/resources
mkdir -p src/test/java/com/ferrari/hooks
mkdir -p src/test/java/com/ferrari/runner
mkdir -p src/test/java/com/ferrari/steps
mkdir -p src/test/resources/features

# Create example package
mkdir -p src/main/java/com/ferrari/examples

echo "Creating pom.xml..."
cat > pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.ferrari</groupId>
    <artifactId>ferrari-automation</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <selenium.version>4.12.1</selenium.version>
        <cucumber.version>7.14.0</cucumber.version>
        <testng.version>7.8.0</testng.version>
        <assertj.version>3.24.2</assertj.version>
        <lombok.version>1.18.30</lombok.version>
        <guice.version>7.0.0</guice.version>
        <log4j.version>2.20.0</log4j.version>
    </properties>

    <dependencies>
        <!-- Selenium -->
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>${selenium.version}</version>
        </dependency>

        <!-- Cucumber -->
        <dependency>
            <groupId>io.cucumber</groupId>
            <artifactId>cucumber-java</artifactId>
            <version>${cucumber.version}</version>
        </dependency>
        <dependency>
            <groupId>io.cucumber</groupId>
            <artifactId>cucumber-testng</artifactId>
            <version>${cucumber.version}</version>
        </dependency>
        <dependency>
            <groupId>io.cucumber</groupId>
            <artifactId>cucumber-guice</artifactId>
            <version>${cucumber.version}</version>
        </dependency>

        <!-- TestNG -->
        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>${testng.version}</version>
            <scope>test</scope>
        </dependency>

        <!-- AssertJ -->
        <dependency>
            <groupId>org.assertj</groupId>
            <artifactId>assertj-core</artifactId>
            <version>${assertj.version}</version>
            <scope>test</scope>
        </dependency>

        <!-- Lombok -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>

        <!-- Guice -->
        <dependency>
            <groupId>com.google.inject</groupId>
            <artifactId>guice</artifactId>
            <version>${guice.version}</version>
        </dependency>

        <!-- Log4j2 -->
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-api</artifactId>
            <version>${log4j.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-core</artifactId>
            <version>${log4j.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>${maven.compiler.source}</source>
                    <target>${maven.compiler.target}</target>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>${lombok.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.2.2</version>
                <configuration>
                    <suiteXmlFiles>
                        <suiteXmlFile>src/test/resources/testng.xml</suiteXmlFile>
                    </suiteXmlFiles>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

echo "Creating config.properties..."
cat > src/main/resources/config.properties << 'EOF'
# Browser Configuration
browser=firefox
headless=false

# URLs
google.url=https://www.google.com
ferrari.sf90.url=https://www.ferrari.com/en-EN/auto/sf90-stradale

# Search Parameters
search.term=ferrari sf90

# Timeouts (in seconds)
timeout.implicit=10
timeout.pageLoad=30
timeout.script=30
EOF

echo "Creating log4j2.xml..."
cat > src/main/resources/log4j2.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="INFO">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
        <File name="File" fileName="logs/test.log" append="false">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </File>
    </Appenders>
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="File"/>
        </Root>
    </Loggers>
</Configuration>
EOF

echo "Creating testng.xml..."
cat > src/test/resources/testng.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">
<suite name="Ferrari Automation Suite">
    <test name="Ferrari SF90 Tests">
        <classes>
            <class name="com.ferrari.runner.TestRunner"/>
        </classes>
    </test>
</suite>
EOF

echo "Creating feature file..."
cat > src/test/resources/features/ferrari_sf90_search.feature << 'EOF'
Feature: Ferrari SF90 Search Validation
  As a user
  I want to search for Ferrari SF90 on Google
  So that I can validate the Ferrari official website

  @ferrari @smoke
  Scenario: Search for Ferrari SF90 and verify official website
    Given I am on the Google homepage
    When I search for "ferrari sf90"
    And I click on the first search result
    Then I should be redirected to the Ferrari SF90 official page
EOF

echo "Creating BrowserType.java..."
cat > src/main/java/com/ferrari/constants/BrowserType.java << 'EOF'
package com.ferrari.constants;

/**
 * Enum representing the available browser types for test execution.
 */
public enum BrowserType {
    CHROME,
    FIREFOX,
    EDGE;

    /**
     * Convert a string to corresponding browser type enum.
     *
     * @param browser the browser name as string
     * @return the matching BrowserType enum
     */
    public static BrowserType fromString(String browser) {
        if (browser == null || browser.isEmpty()) {
            return FIREFOX; // Default browser
        }

        try {
            return valueOf(browser.toUpperCase());
        } catch (IllegalArgumentException e) {
            return FIREFOX; // Default to Firefox if not recognized
        }
    }
}
EOF

echo "Creating TimeoutConstants.java..."
cat > src/main/java/com/ferrari/constants/TimeoutConstants.java << 'EOF'
package com.ferrari.constants;

import java.time.Duration;

/**
 * Constants for various timeouts used in the test framework.
 */
public final class TimeoutConstants {
    private TimeoutConstants() {
        // Private constructor to prevent instantiation
    }

    // Default timeout values in seconds
    public static final int DEFAULT_IMPLICIT_TIMEOUT = 10;
    public static final int DEFAULT_PAGE_LOAD_TIMEOUT = 30;
    public static final int DEFAULT_SCRIPT_TIMEOUT = 30;
    
    // Convert to Duration objects for Selenium usage
    public static Duration getImplicitWaitDuration(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    public static Duration getPageLoadTimeout(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    public static Duration getScriptTimeout(int seconds) {
        return Duration.ofSeconds(seconds);
    }
    
    // Explicit wait constants
    public static final Duration SHORT_WAIT = Duration.ofSeconds(5);
    public static final Duration MEDIUM_WAIT = Duration.ofSeconds(10);
    public static final Duration LONG_WAIT = Duration.ofSeconds(30);
}
EOF

echo "Creating PropertyReader.java..."
cat > src/main/java/com/ferrari/utils/PropertyReader.java << 'EOF'
package com.ferrari.utils;

import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Utility class for reading properties from config files.
 */
@Log4j2
public class PropertyReader {
    private static final Properties properties = new Properties();
    private static final String CONFIG_FILE = "config.properties";
    
    static {
        loadProperties();
    }
    
    private PropertyReader() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Load properties from the config file.
     */
    private static void loadProperties() {
        try (InputStream inputStream = PropertyReader.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
            if (inputStream != null) {
                properties.load(inputStream);
                log.info("Properties loaded successfully from {}", CONFIG_FILE);
            } else {
                log.error("Property file '{}' not found in the classpath", CONFIG_FILE);
            }
        } catch (IOException e) {
            log.error("Failed to load properties file: {}", e.getMessage(), e);
        }
    }
    
    /**
     * Get a property value by key.
     *
     * @param key the property key
     * @return the property value or null if not found
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Get a property value by key with a default value.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found
     * @return the property value or the default value if not found
     */
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * Get a property as an integer.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found or not a valid integer
     * @return the property value as an integer or the default value
     */
    public static int getIntProperty(String key, int defaultValue) {
        String value = getProperty(key);
        if (value == null) {
            return defaultValue;
        }
        
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            log.warn("Failed to parse property '{}' as integer, using default value: {}", key, defaultValue);
            return defaultValue;
        }
    }
    
    /**
     * Get a property as a boolean.
     *
     * @param key the property key
     * @param defaultValue the default value to return if key not found
     * @return the property value as a boolean or the default value
     */
    public static boolean getBooleanProperty(String key, boolean defaultValue) {
        String value = getProperty(key);
        if (value == null) {
            return defaultValue;
        }
        
        return Boolean.parseBoolean(value);
    }
}
EOF

echo "Creating WaitUtils.java..."
cat > src/main/java/com/ferrari/utils/WaitUtils.java << 'EOF'
package com.ferrari.utils;

import com.ferrari.constants.TimeoutConstants;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;

/**
 * Utility class for Selenium wait operations.
 */
@Log4j2
public class WaitUtils {
    
    private WaitUtils() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Wait for an element to be visible.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @param timeout Wait timeout duration
     * @return WebElement once it becomes visible
     */
    public static WebElement waitForElementVisible(WebDriver driver, WebElement element, Duration timeout) {
        log.debug("Waiting for element to be visible with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.visibilityOf(element));
    }
    
    /**
     * Wait for an element to be visible with default medium timeout.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @return WebElement once it becomes visible
     */
    public static WebElement waitForElementVisible(WebDriver driver, WebElement element) {
        return waitForElementVisible(driver, element, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for an element to be clickable.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @param timeout Wait timeout duration
     * @return WebElement once it becomes clickable
     */
    public static WebElement waitForElementClickable(WebDriver driver, WebElement element, Duration timeout) {
        log.debug("Waiting for element to be clickable with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.elementToBeClickable(element));
    }
    
    /**
     * Wait for an element to be clickable with default medium timeout.
     *
     * @param driver WebDriver instance
     * @param element WebElement to wait for
     * @return WebElement once it becomes clickable
     */
    public static WebElement waitForElementClickable(WebDriver driver, WebElement element) {
        return waitForElementClickable(driver, element, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for the page to be fully loaded.
     *
     * @param driver WebDriver instance
     * @param timeout Wait timeout duration
     */
    public static void waitForPageLoad(WebDriver driver, Duration timeout) {
        log.debug("Waiting for page to load with timeout: {}", timeout);
        new WebDriverWait(driver, timeout).until(
                driver1 -> ((JavascriptExecutor) driver1)
                        .executeScript("return document.readyState").equals("complete"));
    }
    
    /**
     * Wait for the page to be fully loaded with default timeout.
     *
     * @param driver WebDriver instance
     */
    public static void waitForPageLoad(WebDriver driver) {
        waitForPageLoad(driver, TimeoutConstants.MEDIUM_WAIT);
    }
    
    /**
     * Wait for a URL to contain a specific text.
     *
     * @param driver WebDriver instance
     * @param urlText Text that the URL should contain
     * @param timeout Wait timeout duration
     */
    public static void waitForUrlToContain(WebDriver driver, String urlText, Duration timeout) {
        log.debug("Waiting for URL to contain '{}' with timeout: {}", urlText, timeout);
        new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.urlContains(urlText));
    }
    
    /**
     * Wait for a URL to be exactly as specified.
     *
     * @param driver WebDriver instance
     * @param url Expected URL
     * @param timeout Wait timeout duration
     */
    public static void waitForUrlToBe(WebDriver driver, String url, Duration timeout) {
        log.debug("Waiting for URL to be '{}' with timeout: {}", url, timeout);
        new WebDriverWait(driver, timeout)
                .until(ExpectedConditions.urlToBe(url));
    }
    
    /**
     * Wait for a custom condition.
     *
     * @param driver WebDriver instance
     * @param condition Custom ExpectedCondition
     * @param timeout Wait timeout duration
     * @param <T> Type of the expected result
     * @return Result of the condition
     */
    public static <T> T waitFor(WebDriver driver, ExpectedCondition<T> condition, Duration timeout) {
        log.debug("Waiting for custom condition with timeout: {}", timeout);
        return new WebDriverWait(driver, timeout).until(condition);
    }
}
EOF

echo "Creating ConfigurationManager.java..."
cat > src/main/java/com/ferrari/config/ConfigurationManager.java << 'EOF'
package com.ferrari.config;

import com.ferrari.constants.BrowserType;
import com.ferrari.constants.TimeoutConstants;
import com.ferrari.utils.PropertyReader;
import lombok.Getter;
import lombok.extern.log4j.Log4j2;

/**
 * Class responsible for managing test configuration.
 */
@Log4j2
@Getter
public class ConfigurationManager {
    private final BrowserType browserType;
    private final boolean headless;
    private final String googleUrl;
    private final String ferrariSF90Url;
    private final String searchTerm;
    private final int implicitTimeout;
    private final int pageLoadTimeout;
    private final int scriptTimeout;
    
    /**
     * Singleton instance of ConfigurationManager.
     */
    private static ConfigurationManager instance;
    
    /**
     * Get the singleton instance of ConfigurationManager.
     *
     * @return ConfigurationManager instance
     */
    public static synchronized ConfigurationManager getInstance() {
        if (instance == null) {
            instance = new ConfigurationManager();
        }
        return instance;
    }
    
    /**
     * Private constructor to enforce singleton pattern.
     * Loads configuration from properties file.
     */
    private ConfigurationManager() {
        // Browser configuration
        this.browserType = BrowserType.fromString(PropertyReader.getProperty("browser", "firefox"));
        this.headless = PropertyReader.getBooleanProperty("headless", false);
        
        // URLs
        this.googleUrl = PropertyReader.getProperty("google.url", "https://www.google.com");
        this.ferrariSF90Url = PropertyReader.getProperty("ferrari.sf90.url", "https://www.ferrari.com/en-EN/auto/sf90-stradale");
        
        // Search parameters
        this.searchTerm = PropertyReader.getProperty("search.term", "ferrari sf90");
        
        // Timeouts
        this.implicitTimeout = PropertyReader.getIntProperty("timeout.implicit", TimeoutConstants.DEFAULT_IMPLICIT_TIMEOUT);
        this.pageLoadTimeout = PropertyReader.getIntProperty("timeout.pageLoad", TimeoutConstants.DEFAULT_PAGE_LOAD_TIMEOUT);
        this.scriptTimeout = PropertyReader.getIntProperty("timeout.script", TimeoutConstants.DEFAULT_SCRIPT_TIMEOUT);
        
        logConfiguration();
    }
    
    /**
     * Log the current configuration.
     */
    private void logConfiguration() {
        log.info("Test Configuration:");
        log.info("Browser: {}", browserType);
        log.info("Headless: {}", headless);
        log.info("Google URL: {}", googleUrl);
        log.info("Ferrari SF90 URL: {}", ferrariSF90Url);
        log.info("Search Term: {}", searchTerm);
        log.info("Implicit Timeout: {} seconds", implicitTimeout);
        log.info("Page Load Timeout: {} seconds", pageLoadTimeout);
        log.info("Script Timeout: {} seconds", scriptTimeout);
    }
}
EOF

echo "Creating DriverManager.java..."
cat > src/main/java/com/ferrari/config/DriverManager.java << 'EOF'
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
EOF

echo "Creating GuiceModule.java..."
cat > src/main/java/com/ferrari/config/GuiceModule.java << 'EOF'
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
EOF

echo "Creating BasePage.java..."
cat > src/main/java/com/ferrari/pages/BasePage.java << 'EOF'
package com.ferrari.pages;

import com.ferrari.utils.WaitUtils;
import lombok.extern.log4j.Log4j2;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import javax.inject.Inject;

/**
 * Base page class that all page objects extend.
 */
@Log4j2
public abstract class BasePage {
    protected final WebDriver driver;
    
    /**
     * Constructor for base page with WebDriver injection.
     *
     * @param driver WebDriver instance
     */
    @Inject
    public BasePage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        log.debug("Initialized {}", this.getClass().getSimpleName());
    }
    
    /**
     * Navigate to a URL.
     *
     * @param url URL to navigate to
     */
    public void navigateTo(String url) {
        log.info("Navigating to: {}", url);
        driver.navigate().to(url);
        WaitUtils.waitForPageLoad(driver);
    }
    
    /**
     * Get the current URL.
     *
     * @return current URL
     */
    public String getCurrentUrl() {
        return driver.getCurrentUrl();
    }
    
    /**
     * Click on an element with explicit wait.
     *
     * @param element WebElement to click
     */
    protected void click(WebElement element) {
        log.debug("Clicking element: {}", element);
        WaitUtils.waitForElementClickable(driver, element).click();
    }
    
    /**
     * Enter text into an element with explicit wait.
     *
     * @param element WebElement to enter text into
     * @param text text to enter
     */
    protected void sendKeys(WebElement element, String text) {
        log.debug("Sending text to element: {}", element);
        WaitUtils.waitForElementVisible(driver, element).sendKeys(text);
    }
    
    /**
     * Check if an element is displayed with explicit wait.
     *
     * @param element WebElement to check
     * @return true if element is displayed, false otherwise
     */
    protected boolean isElementDisplayed(WebElement element) {
        try {
            return WaitUtils.waitForElementVisible(driver, element).isDisplayed();
        } catch (Exception e) {
            log.debug("Element is not displayed: {}", element);
            return false;
        }
    }
    
    /**
     * Get text from an element with explicit wait.
     *
     * @param element WebElement to get text from
     * @return text of the element
     */
    protected String getText(WebElement element) {
        return WaitUtils.waitForElementVisible(driver, element).getText();
    }
    
    /**
     * Execute JavaScript.
     *
     * @param script JavaScript to execute
     * @param args arguments to pass to script
     * @return result of script execution
     */
    protected Object executeJavaScript(String script, Object... args) {
        log.debug("Executing JavaScript: {}", script);
        return ((JavascriptExecutor) driver).executeScript(script, args);
    }
}
EOF

echo "Creating GoogleHomePage.java..."
cat > src/main/java/com/ferrari/pages/GoogleHomePage.java << 'EOF'
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
EOF

echo "Creating GoogleSearchResultsPage.java..."
cat > src/main/java/com/ferrari/pages/GoogleSearchResultsPage.java << 'EOF'
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
EOF

echo "Creating FerrariSF90Page.java..."
cat > src/main/java/com/ferrari/pages/FerrariSF90Page.java << 'EOF'
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
EOF

echo "Creating TestHooks.java..."
cat > src/test/java/com/ferrari/hooks/TestHooks.java << 'EOF'
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
EOF

echo "Creating TestRunner.java..."
cat > src/test/java/com/ferrari/runner/TestRunner.java << 'EOF'
package com.ferrari.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.DataProvider;

/**
 * TestNG Cucumber runner.
 */
@CucumberOptions(
        features = "src/test/resources/features",
        glue = {"com.ferrari.steps", "com.ferrari.hooks"},
        plugin = {
                "pretty",
                "html:target/cucumber-reports/cucumber-pretty.html",
                "json:target/cucumber-reports/cucumber-report.json",
                "junit:target/cucumber-reports/cucumber-results.xml"
        },
        monochrome = true,
        tags = ""
)
public class TestRunner extends AbstractTestNGCucumberTests {
    
    /**
     * Runs scenarios in parallel if enabled.
     *
     * @return DataProvider instance
     */
    @Override
    @DataProvider(parallel = false)
    public Object[][] scenarios() {
        return super.scenarios();
    }
}
EOF

echo "Creating GoogleHomePageSteps.java..."
cat > src/test/java/com/ferrari/steps/GoogleHomePageSteps.java << 'EOF'
package com.ferrari.steps;

import com.ferrari.config.ConfigurationManager;
import com.ferrari.pages.GoogleHomePage;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import lombok.extern.log4j.Log4j2;

import javax.inject.Inject;

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
EOF

echo "Creating GoogleSearchResultsSteps.java..."
cat > src/test/java/com/ferrari/steps/GoogleSearchResultsSteps.java << 'EOF'
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
EOF

echo "Creating FerrariSF90Steps.java..."
cat > src/test/java/com/ferrari/steps/FerrariSF90Steps.java << 'EOF'
package com.ferrari.steps;

import com.ferrari.config.ConfigurationManager;
import com.ferrari.pages.FerrariSF90Page;
import io.cucumber.java.en.Then;
import lombok.extern.log4j.Log4j2;

import javax.inject.Inject;

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
     * @param configManager ConfigurationManager instance
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
EOF

echo "Creating example usage..."
cat > src/main/java/com/ferrari/examples/FerrariTestExample.java << 'EOF'
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
EOF

# Make the script executable
chmod +x generate-project.sh

echo ""
echo "Ferrari Automation Framework project structure generated successfully!"
echo "The project is ready to be imported into IntelliJ IDEA as a Maven project."
echo ""
echo "To run the Cucumber tests: mvn clean test"
EOF

chmod +x $ROOT_DIR/generate-project.sh

echo "Linux/macOS script created successfully: $ROOT_DIR/generate-project.sh"
