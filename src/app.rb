require 'obtainer'
require 'couchdb_inserter'
require 'couchdb_converter'
require 'json'

o = Obtainer.new
puts "Getting Popular Artists"
artists = o.get_popular_artists

#releases = []
#artists.each do |a|
#  releases << o.get_artists_releases(a)['Releases']['Release']
#end


converter = CouchdbConverter.new
docs = []
puts "Coverting Artists"
docs << converter.to_artist_document(artists)

#releases.each do |r|
#  docs << converter.to_album_document(r.to_json)
#end

inserter = CouchdbInserter.new

puts "Inserting"
docs.each do |d|
  d.each do |d2|
    inserter.put(d2)
    puts "Inserted"
  end
end
