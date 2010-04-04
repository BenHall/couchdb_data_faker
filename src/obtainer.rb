require 'json'
require 'net/http'
require 'yaml'

class Obtainer
  def query(base_url, results, start)
    url = "#{base_url}&results=#{results}&start=#{start}"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    return data
  end

  def get_popular_artists(results=100, start=1)
   base_url = "http://us.music.yahooapis.com/artist/v1/list/published/popular?format=json&appid=" + get_key()
   data = query(base_url, results, start)

   return JSON.parse(data)
  end

  def get_similar_artists(artist, results=100, start=1)
   base_url = "http://us.music.yahooapis.com/artist/v1/list/similar/#{artist['id']}?format=json&appid=#{get_key()}"
   data = query(base_url, results, start)

   return JSON.parse(data)
  end

  def join_results(set_one, set_two)
    result = set_one
    set_two.each do |k, v|
      result << {k, v} unless set_one.include?(k)
    end

    result
  end

  def get_key
    config = YAML::load get_config_file_path()
    config['api-key']
  end

  def get_config_file_path
    File.open(File.join(File.dirname(__FILE__), 'config.yml'))
  end
end