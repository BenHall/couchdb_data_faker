require 'json'
require 'pp'
class CouchdbConverter
  def to_artist_document(parsed_json)
    @result = []
    parsed_json['Artists']['Artist'].each do |a|
      hash = {"id" => a['id'],
              "name" => a['name'],
              "website" => a['website'],
              "tags" => ["Popular"],
              "type" => "artist"
             }
      @result << hash.to_json
    end
    @result
  end

  def to_album_document(parsed_json)
    @result = []
    parsed_json['Releases']['Release'].each do |r|
      artist_id = get_artist_id_from_release(r)
      hash = {"id" => r['id'],
              "type" => "album",
              "title" => r['title'],
              "tracks" => ["Track 1", "Track 2", "Track 3", "Track 4", "Track 5"],
              "artist" => artist_id,
              "release_date" => r['releaseDate'],
              "tags" => [r['releaseYear']],
              "label" => r['label'],
              "upc" => r['UPC']
             }
      @result << hash.to_json
    end
    @result
  end

  private
  def get_artist_id_from_release(release)
    artist_id = release['Artist']['id'] unless release['Artist'].class == Array
    artist_id = release['Artist'][0]['id'] if release['Artist'].class == Array
    return artist_id
  end
end