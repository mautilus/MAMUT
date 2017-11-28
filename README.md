# MAMUT
#1 Roku Unit Testing System by Mautilus
===========

### 1. What is MAMUT?
 
Mamut is a test deploy-run-present software for Roku platform.
 
- It has a quick and easy installation and setup, supporting all operating systems.
- After that, it allows you to easily deploy and run tests on multiple Roku devices in local network at the same time, collects the results and presents them in comprehensible and exportable form. And all that in a simple UI in your browser.
- Roku tests are written in the same language as the code (Brightscript) – so no need for your developers to learn a new language. They are using a lightweight, non-invasive framework. You only need to copy few files into your project and make a small change to your main file to be able to run the tests – all with a minimal impact on your code base.
- Each test set/case is a separate file in a dedicated directory of your project containing the actual tests as simple functions.

### 2. The MAMUT core

The core or MAMUT is a server written in Node.js. It is therefore easily deployable to all OS with a minimal setup. It then takes care of deployment of app package with test sets/cases to selected devices.
The user connects to server trough a web browser.
Server contains local network device discovery for Roku devices.

After selecting the devices and test sets/cases, it deploys the packages and waits for the results from the Roku devices for a certain time span and presents them to the connected 'clients'.
User sees in the browser the test results and can export these as a pdf or csv for further machine processing.

### 3. Roku Test Framework


The test framework for Roku consists of a few files which contain 'classes' required to run the actual tests and delivering the results to the MAMUT core; as well as file(s) containing the assert function that the test authors may use. These need to be copied to a specific path in your project, packaged and uploaded via the web UI to the MAMUT core. This then extracts the test set/case list from the package and offers the user the selection of tests he desires to run.
In addition, it is required to change the app main entry point so it can be intercepted to run the tests.
The actual tests set/case is a single file with a specific structure in a specific directory in a package.
It contains header declaring the files that are required – files which functions are used or tested.
Main function creating the test set / case 'object' returned to the MAMUT core as a result.
Lastly the file contains the tests as functions which are called from the Main function.
​
After selecting the devices and test sets/cases, it deploys the packages and waits for the results from the Roku devices for a certain time span and presents them to the connected 'clients'.
User sees in the browser the test results and can export these as a pdf or csv for further machine processing.


### 4. Contact

- E-mail: technical_support@mautilus.com
- Web: www.mamuttool.com

Feel free to contact us if you have any technical question or check our web www.mamuttool.com 
