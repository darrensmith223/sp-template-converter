require 'net/http'
require 'JSON'
require 'rubygems'
require 'nokogiri'

def get_template(api_key, template_id)
  uri = URI("https://api.sparkpost.com/api/v1/templates/" + template_id)
  req = Net::HTTP::Get.new(uri)
  req['Authorization'] = api_key

  res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http|
    http.request(req)
  }

  results = JSON.parse(res.body)

  return results

end

def update_template(api_key, template_id, content_obj)
  uri = URI("https://api.sparkpost.com/api/v1/templates/" + template_id)
  req = Net::HTTP::Put.new(uri)
  req['Authorization'] = api_key
  body_obj = {"content": content_obj}
  req.body = body_obj.to_json


  res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
  }

end

def publish_template(api_key, template_id)
  uri = URI("https://api.sparkpost.com/api/v1/templates/" + template_id)
  req = Net::HTTP::Put.new(uri)
  req['Authorization'] = api_key
  body_obj = {"published": true}
  req.body = body_obj.to_json

  res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req)
  }

end

# Import Arguments - Command Line
api_key = ARGV[0]
template_id = ARGV[1]

# Get HTML from Template
results = get_template(api_key, template_id)

# Convert HTML into Text
content_obj = results.fetch("results").fetch("content")
html = content_obj.fetch("html")
text = Nokogiri::HTML(html).text

# Update SP tempaltes with text-only
content_obj["text"] = text
update_template(api_key, template_id, content_obj)

# Publish Templates
publish_template(api_key, template_id)
