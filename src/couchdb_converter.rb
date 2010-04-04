require 'json'
class CouchdbConverter
  def to_artist_document(parsed_json)
    @result = []
    parsed_json['Artists']['Artist'].each do |a|
      hash = {"name" => a['name'], "website" => a['website'], "tags" => ["Popular"]}
      @result << hash.to_json
    end
    @result
  end
end