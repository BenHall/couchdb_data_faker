require "net/http"

class CouchdbInserter
  def put(json)
    load_config()
    http = Net::HTTP.new(get_key('server'), get_key('port').to_s)
    
    request = Net::HTTP::Put.new("/" + get_key('db'))
    request.set_form_data(json)
    http.request(request)
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