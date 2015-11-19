<?php
/**
 * Run this with "phpunit testRemoteSelenium.php"
 *
 * This checks that calling (the host machine's) localhost:7001 (or 192.168.33.10:80 - IP set in the Vagrantfile),
 * then display a page with phpinfo().
 *
 * The phpinfo() is served from the sample shared/website/index.php via the guest machine's Apache2 default setup
 * (using /var/www/html that is mapped to the shared/website host folder).
 *
 * The setup was designed so that you'll change "shared/website" - either by mapping to another folder (ex: ../real.project/public)
 * or by updating the contents in shared/website/ and using the folder as the starting point.
 *
 * In this sample/setup,
 * localhost:7001 is linked to the guest machine's 80 port and
 * localhost:7002 is linked to the guest machine's 8321 port (set in phpunit-selenium-env as Selenium Server's port) and
 * 192.168.33.10 is the static private IP set for the guest, accessible only from the host machine
 */

$autoload = __DIR__ . '/vendor/autoload.php';
if (!file_exists($autoload)) {
    die('run "composer install" in tests/');
}

require_once $autoload;

use Facebook\WebDriver\Remote\RemoteWebDriver;
use Facebook\WebDriver\Remote\WebDriverCapabilityType;
use Facebook\WebDriver\WebDriverBy;

class RemoteSeleniumTest extends \PHPUnit_Framework_TestCase
{
    /**
     * When calling localhost then return the PHP version title as non-empty string.
     */
    public function testWhenCallingLocalhostThenReturnThePHPVersionTitleAsNonEmptyString()
    {
        $capabilities = [WebDriverCapabilityType::BROWSER_NAME => 'firefox'];
        $webDriver = RemoteWebDriver::create('http://192.168.33.10:8321/wd/hub', $capabilities);

        $webDriver->get('http://localhost:7001');
        $elements = $webDriver->findElements(WebDriverBy::tagName('h1'));
        $headerElement = array_shift($elements);

        self::assertNotEmpty($headerElement->getText());
        $webDriver->quit();
    }
}
