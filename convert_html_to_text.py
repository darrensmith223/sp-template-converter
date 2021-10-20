import argparse
from bs4 import BeautifulSoup
import requests
import json


def get_template(api_key, template_id):
    url = "https://api.sparkpost.com/api/v1/templates/" + template_id
    headers = {"Authorization": api_key, "Content-Type": "application/json"}
    response = requests.get(url, headers=headers)
    result_obj = json.loads(response.text)

    return result_obj.get("results")


def update_template_text(api_key, template_id, content_obj):
    url = "https://api.sparkpost.com/api/v1/templates/" + template_id
    headers = {"Authorization": api_key, "Content-Type": "application/json"}
    data = {"content": content_obj}
    response = requests.put(url, json=data, headers=headers)

    return response


def publish_template(api_key, template_id):
    url = "https://api.sparkpost.com/api/v1/templates/" + template_id
    headers = {"Authorization": api_key, "Content-Type": "application/json"}
    data = {"published": True}
    response = requests.put(url, json=data, headers=headers)

    return response


if __name__ == "__main__":
    # Import Arguments - Command Line
    parser = argparse.ArgumentParser(description="Update a SparkPost HTML Template to include a text-only version")
    parser.add_argument("api_key", type=str, help="SparkPost API Key")
    parser.add_argument("template_id", type=str, help="SparkPost Template ID to use")
    args = parser.parse_args()

    api_key = args.api_key
    template_id = args.template_id

    # Get HTML From SP Template
    html_obj = get_template(api_key, template_id)
    html = html_obj.get("content").get("html")

    # Convert HTML into Text
    soup = BeautifulSoup(html, features="html.parser")
    text = soup.get_text()

    # Update SP Template with text-only
    content_obj = html_obj.get("content")
    content_obj["text"] = text
    update_template_text(api_key, template_id, content_obj)

    # Publish Updated Template
    publish_template(api_key, template_id)
