# Ferrari Automation Framework

A comprehensive Selenium test automation framework for web application testing, built using Page Object Model, Cucumber BDD, TestNG, and Google Guice for dependency injection.

## Table of Contents

- [Project Structure](#project-structure)
- [Framework Architecture](#framework-architecture)
- [Setup Instructions](#setup-instructions)
- [Running Tests](#running-tests)
- [Features](#features)
- [Technologies](#technologies)

## Project Structure

```
FerrariAutomation/
├── pom.xml
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── ferrari/
│   │   │           ├── config/
│   │   │           │   ├── ConfigurationManager.java
│   │   │           │   ├── DriverManager.java
│   │   │           │   └── GuiceModule.java
│   │   │           ├── constants/
│   │   │           │   ├── BrowserType.java
│   │   │           │   └── TimeoutConstants.java
│   │   │           ├── pages/
│   │   │           │   ├── BasePage.java
│   │   │           │   ├── GoogleHomePage.java
│   │   │           │   ├── GoogleSearchResultsPage.java
│   │   │           │   └── FerrariSF90Page.java
│   │   │           └── utils/
│   │   │               ├── PropertyReader.java
│   │   │               └── WaitUtils.java
│   │   └── resources/
│   │       ├── config.properties
│   │       └── log4j2.xml
│   └── test/
│       ├── java/
│       │   └── com/
│       │       └── ferrari/
│       │           ├── hooks/
│       │           │   └── TestHooks.java
│       │           ├── runner/
│       │           │   └── TestRunner.java
│       │           └── steps/
│       │               ├── FerrariSF90Steps.java
│       │               ├── GoogleHomePageSteps.java
│       │               └── GoogleSearchResultsSteps.java
│       └── resources/
│           ├── features/
│           │   └── ferrari_sf90_search.feature
│           └── testng.xml
```

### Detailed Structure Explanation

#### Root Structure

- **FerrariAutomation/**: The root directory of the project.
- **pom.xml**: Maven Project Object Model file that defines project dependencies, build configurations, and plugins. This is essential for managing the project's libraries and build lifecycle.

#### Source Code Structure

The project follows Maven's standard directory layout, divided into `main` (application code) and `test` (test code).

##### Main Source Code

###### `src/main/java/com/ferrari/config/`

This package contains configuration-related classes:

- **ConfigurationManager.java**: 
  - Implements the Singleton pattern to ensure a single configuration instance
  - Loads properties from `config.properties` file
  - Provides getters for all configuration values
  - Stores browser settings, URLs, search terms, and timeout values

- **DriverManager.java**: 
  - Manages WebDriver instances (ChromeDriver, FirefoxDriver, EdgeDriver)
  - Configures browser options (headless mode, maximize window)
  - Sets up timeout configurations
  - Provides methods to get and quit the WebDriver

- **GuiceModule.java**: 
  - Google Guice configuration for dependency injection
  - Binds interfaces to implementations
  - Sets up singleton scopes for important classes
  - Provides WebDriver instance to components that need it

###### `src/main/java/com/ferrari/constants/`

Contains constant values and enumerations:

- **BrowserType.java**: 
  - Enum for supported browsers (CHROME, FIREFOX, EDGE)
  - Provides utility method to convert string browser name to enum

- **TimeoutConstants.java**: 
  - Defines default timeout values for various operations
  - Provides methods to convert seconds to Duration objects
  - Contains constants for short, medium, and long waits

###### `src/main/java/com/ferrari/pages/`

Implements the Page Object Model pattern:

- **BasePage.java**: 
  - Abstract class that all page objects extend
  - Initializes Page Factory for WebElement annotations
  - Provides common methods like click, sendKeys, isElementDisplayed
  - Handles JavaScript execution and navigation

- **GoogleHomePage.java**: 
  - Represents Google's homepage
  - Contains elements like search input and search button
  - Provides methods to navigate to Google and perform searches

- **GoogleSearchResultsPage.java**: 
  - Represents Google's search results page
  - Finds and interacts with search result links
  - Provides methods to click on search results

- **FerrariSF90Page.java**: 
  - Represents the Ferrari SF90 official page
  - Contains validation methods for URL and page content
  - Provides access to Ferrari-specific page elements

###### `src/main/java/com/ferrari/utils/`

Utility classes for common operations:

- **PropertyReader.java**: 
  - Loads and reads properties from configuration files
  - Provides type-safe methods to get string, integer, and boolean properties
  - Handles default values and error cases

- **WaitUtils.java**: 
  - Provides explicit wait utilities for various conditions
  - Includes methods for waiting for elements, page loads, and URL changes
  - Implements best practices for Selenium waits

###### `src/main/resources/`

Configuration files:

- **config.properties**: 
  - Contains key-value pairs for configurable options
  - Includes browser settings, URLs, search terms, and timeouts
  - Can be easily modified without changing code

- **log4j2.xml**: 
  - Log4j2 configuration for logging
  - Defines console and file appenders
  - Sets logging levels and patterns

##### Test Source Code

###### `src/test/java/com/ferrari/hooks/`

Cucumber hooks for setup and teardown:

- **TestHooks.java**: 
  - Contains `@Before` and `@After` methods executed around scenarios
  - Handles WebDriver setup and cleanup
  - Takes screenshots on test failures

###### `src/test/java/com/ferrari/runner/`

Test execution configuration:

- **TestRunner.java**: 
  - TestNG and Cucumber integration
  - Defines feature file locations, glue code, and plugins
  - Configures report generation and parallel execution options

###### `src/test/java/com/ferrari/steps/`

Cucumber step definition classes:

- **FerrariSF90Steps.java**: 
  - Implements steps related to Ferrari SF90 page validation
  - Verifies URL and page content
  - Uses AssertJ for fluent assertions

- **GoogleHomePageSteps.java**: 
  - Implements steps for Google homepage interactions
  - Handles navigation to Google
  - Performs search operations

- **GoogleSearchResultsSteps.java**: 
  - Implements steps for search results interactions
  - Clicks on search results
  - Verifies search results presence

###### `src/test/resources/features/`

Cucumber feature files:

- **ferrari_sf90_search.feature**: 
  - Defines test scenarios in Gherkin syntax
  - Contains Given-When-Then steps for end-to-end tests
  - Written in business-readable language

###### `src/test/resources/`

Test configuration:

- **testng.xml**: 
  - TestNG configuration file
  - Defines test suites and classes to execute
  - Configures listeners and execution options

## Framework Architecture

The framework is built on the following architectural principles:

1. **Separation of Concerns**:
   - Pages handle UI interactions
   - Step definitions connect Gherkin to code
   - Configuration manages environment settings
   - Utilities provide reusable helper methods

2. **Dependency Injection with Guice**:
   - Reduces tight coupling between components
   - Makes testing easier through mock injection
   - Centralizes object creation and lifecycle management

3. **Page Object Model**:
   - Each web page has a corresponding class
   - Encapsulates page structure and behavior
   - Makes tests more maintainable when UI changes

4. **Behavior-Driven Development with Cucumber**:
   - Scenarios written in plain language
   - Steps mapped to code via annotations
   - Promotes collaboration between technical and non-technical stakeholders

5. **Test Execution with TestNG**:
   - Powerful test runner with parallel execution support
   - Annotations for test configuration
   - Integration with Cucumber for BDD

## Setup Instructions

### Prerequisites

- Java JDK 11 or higher
- Maven 3.6.3 or higher
- IntelliJ IDEA (recommended)
- Web browsers: Chrome, Firefox, and/or Edge

### Installation

1. Clone the repository or generate the project using the provided scripts:

   For Linux/macOS:
   ```bash
   ./generate-project.sh
   ```

   For Windows:
   ```bash
   generate-project.bat
   ```

2. Import the project into IntelliJ IDEA:
   - Open IntelliJ IDEA
   - Select "Import Project" or "Open"
   - Navigate to the `FerrariAutomation` directory
   - Select the `pom.xml` file
   - Check "Import Maven projects automatically"
   - Follow the prompts to complete the import

3. Install browser drivers:
   - The framework is configured to use WebDriverManager which will automatically download the correct drivers

## Running Tests

### Using Maven

Run all tests with Maven:

```bash
mvn clean test
```

Run with specific browser:

```bash
mvn clean test -Dbrowser=chrome
```

### Using IntelliJ IDEA

1. Navigate to `src/test/java/com/ferrari/runner/TestRunner.java`
2. Right-click and select "Run TestRunner"

### Using Tags

To run specific tests with tags:

```bash
mvn clean test -Dcucumber.filter.tags="@ferrari"
```

## Features

- **Cross-browser Testing**: Support for Chrome, Firefox, and Edge
- **Configurable Execution**: Easy to change settings via properties file
- **Detailed Logging**: Comprehensive logging with Log4j2
- **Screenshots on Failure**: Automatic capture of screenshots for failed tests
- **HTML Reports**: Cucumber HTML reports for better test analysis
- **Parallel Execution**: Support for running tests in parallel (can be enabled in TestNG)
- **Clean Separation of Concerns**: Follows best practices for test architecture

## Technologies

- Selenium WebDriver 4.x
- Cucumber 7.x
- TestNG 7.x
- Google Guice 7.x
- AssertJ 3.x
- Lombok
- Log4j2
- Maven
