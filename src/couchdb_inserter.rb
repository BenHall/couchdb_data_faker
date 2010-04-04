require "net/http"
require 'json'

class CouchdbInserter
  def issue_request (json, request)
    request.body = json
    response = Net::HTTP.new(get_key('server'), get_key('port')).start do |http|
      http.request(request)
    end
    puts "Response #{response.code} #{response.message}: #{response.body}"
    response
  end

  def put(json)
    hash = JSON.parse(json)
    load_config()

    request = Net::HTTP::Put.new("/#{get_key('db')}/#{hash['id']}")
    issue_request(json, request)
  end

  def create_db()
    load_config()
    request = Net::HTTP::Put.new("/#{get_key('db')}")
    issue_request("", request)
  end

  def load_config
    @config = YAML::load get_server_file_path()
  end

  def get_key(key)
    @config[key]
  end

  def get_server_file_path
    File.open(File.join(File.dirname(__FILE__), 'server.yml'))
  end
end