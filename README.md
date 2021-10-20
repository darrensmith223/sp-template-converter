# sp-template-converter

A simple command line tool to convert a SparkPost HTML template to include a text-only version.  The tool works by retrieving the HTML version of a SparkPost Stored Template, generating a text-only version of the contents, and then updating the stored template to include the generated text-only version.


## How to Use

Templates can be converted using the command line tool.  The tool is comprised of a single file, which is currently supported for the following languages:

* Python - `convert_html_to_text.py`
* Ruby - `convert_html_to_text.rb`

You can save a local copy of the file for the preferred language and execute using the command line by passing in the required arguments `api_key` and `template_id`.

### Creating an API Key

SparkPost API keys can be created within the SparkPost UI by navigating to "API Keys" under configurations.  Note that Admin permissions are needed to create an API key.

### Finding the Template ID

Every SparkPost Stored Template is assigned a unique Template ID, which is required whenever accessing the template via the SparkPost APIs or sending an email using the stored template.  The Template ID can be found by opening the template within the SparkPost UI and navigating to template settings.

### Examples 

```commandline
convert_html_to_text.py your_api_key template_to_use
```

```commandline
ruby convert_html_to_text.rb your_api_key template_to_use
```
