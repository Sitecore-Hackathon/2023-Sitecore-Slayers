# Hackathon Submission Entry form

## Team name
Sitecore Slayers

## Category
Best Enhancement to XM Cloud

## Description
We created a module that takes content from an existing Sitecore item and generates various pieces of metadata for that item and updates it's relavent fields.

  - Allows for the user to select any field as the source of content
  - Allows for the user to specify which fields they'd like to update for each area
    - Page Title
    - Meta Keywords
    - Meta Description

## Video link
[YouTube:  Sitecore Slayers Hackathon 2023 Submission](https://www.youtube.com/watch?v=CGJiWkpY33E)

## Pre-requisites and Dependencies

- Docker Desktop
- Visual Studio
- IIS Disabled / All ports at 80 and 443 disabled
- Chat GPT API Key provided by the key (previously provided to the judges)

## Installation instructions

1. Clone this repository with the 'main' branch.
2. Open PowerShell as an Administrator and set the path as the root of the solution.
3. Run the following command to initialize the project with your license key (assuming your license is at C:\sitecore):

    ```.\init.ps1 -InitEnv -LicenseXmlPath "C:\Sitecore\license.xml" -AdminPassword "Slayers"```
4. Upon completion of the task run the 'up' command to create the Docker images:

    ```.\up.ps1```

5. Validate and accept the machine authorization message when its opened in a browser.
6. Once the scripts have completed and the site is opened in a browser, publish the code from the repository with Visual Studio or run the following command in your PowerShell window:

    ```dotnet publish .\XmCloudSXAStarter.sln```

### Configuration
An API key has been provided to the adjusted to use with the module.  If for some reason it's not working please reach out to Dave Ambrose on Slack for a fresh API key for testing.

## Usage instructions

To use the Metadata Generator simply open the Content Editor in Sitecore XM Cloud and navigate to a page with content to generate the information from.  In our sample this path is:  [PROVIDE PATH]

Once the page is found right click on it and navigate to Scripts -> Sitecore Slayers -> Metadata Generator and click the item to launch the Metadata Generator modal.

With the modal open select a field for each of the dropdown values:

**Source Content** - This is the field that contains the information you're using as the source of truth for the generation of the additional data fields.

**Keywords** - Set this to the proper field for Keywords (field: Keywords)

**Description** - Set this to the proper field for Description (field: Description)

**Page Title** - Set this to the proper field for Page Title (field: Title)

Click Execute and the tool will generate the info.  When it's done simply close the window and you'll see the newly generated content.

## Comments
We could see expanding this module to provide much more functionality than just generating metadata.