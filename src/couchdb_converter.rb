require 'json'
require 'pp'
class CouchdbConverter
  def to_artist_document(parsed_json)
    @result = []
    parsed_json['Artists']['Artist'].each do |a|
      hash = {"id" => a['id'],
              "name" => a['name'],
              "website" => a['website'],
              "tags" => ["Popular", "rock"],
              "type" => "artist",
              "photo" => ["http://cdn.7static.com/static/img/artistimages/00/001/434/0000143451_150.jpg"]
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
              "tracks" => [
                      {
                        "order" => 1,
                        "title" => "Track 1",
                        "restricted" => [3],
                        "length" => "3:20",
                        "price" => ["base" => 0.79, "1" => 0.50, "2" => 0.99],
                        "preview_link" => "http://www.google.com",
                        "media_link" => "http://www.bing.com"
                      },
                      {
                        "order" => 2,
                        "title" => "Track 2",
                        "restricted" => [1],
                        "length" => "3:20",
                        "price" => ["base" => 0.79, "1" => 0.50, "3" => 0.99],
                        "preview_link" => "http://www.google.com",
                        "media_link" => "http://www.bing.com"
                      },
                      {
                        "order" => 3,
                        "title" => "Track 3",
                        "length" => "3:20",
                        "price" => ["base" => 0.79, "1" => 0.50, "2" => 0.79, "3" => 0.99],
                        "preview_link" => "http://www.google.com",
                        "media_link" => "http://www.bing.com"
                      },
                      {
                        "order" => 4,
                        "title" => "Track 4",
                        "restricted" => [1,2],
                        "length" => "3:20",
                        "price" => ["base" => 0.79, "3" => 0.99],
                        "preview_link" => "http://www.google.com",
                        "media_link" => "http://www.bing.com"
                      }
                    ],
              "artist" => artist_id,
              "release_date" => r['releaseDate'],
              "restricted" => [3],
              "format" => ["mp3_320", "aac_320"],
              "price" => ["base" => 4.99, "1" => 1.99, "2" => 4.99],
              "full_price" => ["base" => 6.99, "1" => 5.99, "2" => 4.99],
              "preview_link" => "http://www.google.com",
              "media_link" => "http://www.bing.com",
              "artwork" => ["http://cdn.7static.com/static/img/sleeveart/00/007/743/0000774315_350.jpg"],
              "tags" => [r['releaseYear'], "indie"],
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