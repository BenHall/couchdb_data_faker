require "spec"
$: << 'src/'
require "couchdb_converter"

describe "Convert artist to CouchDB format" do
    # "Name": ""
    # "type": "artist"
    # "Website": ""
    # "Tags" ["Popular"]
    # "Photos" []

  before(:all) do
    json_input =
        "{\"Artists\":{\"errorCount\":\"0\",\"name\":\"Top Artists\",\"total\":\"100\",\"description\":\"Top Artists by Popularity\",\"start\":\"1\",\"Artist\":[{\"hotzillaID\":\"1804705859\",\"rating\":\"-1\",\"name\":\"Beyonce\",\"flags\":\"124611\",\"catzillaID\":\"1927358031\",\"trackCount\":\"694\",\"url\":\"http://new.music.yahoo.com/beyonce/\",\"ItemInfo\":{\"ChartPosition\":{\"last\":\"1\",\"this\":\"1\"}},\"website\":\"http://www.beyonceonline.com/\",\"id\":\"301363\"},{\"hotzillaID\":\"1808430044\",\"rating\":\"-1\",\"name\":\"Kelly Clarkson\",\"flags\":\"59011\",\"catzillaID\":\"0\",\"trackCount\":\"311\",\"url\":\"http://new.music.yahoo.com/kelly-clarkson/\",\"ItemInfo\":{\"ChartPosition\":{\"last\":\"2\",\"this\":\"2\"}},\"website\":\"http://www.kellyclarkson.com/\",\"id\":\"295638\"}],\"count\":\"2\"}}"

    parsed_input = JSON.parse(json_input)

    @converter = CouchdbConverter.new
    @result = @converter.to_artist_document parsed_input
  end
  it "should return two artists" do
    @result.length.should == 2
  end

  it "should contain the name of both artists" do
    @result[0].should include("\"name\":\"Beyonce\"")
    @result[1].should include("\"name\":\"Kelly Clarkson\"")
  end

  it "should contain type 'artist'" do
    @result[0].should include("\"type\":\"artist\"")
    @result[1].should include("\"type\":\"artist\"")
  end
end

describe "Convert release to CouchDB document format" do
  before(:each) do
    json_input =
        "{\"Releases\":{\"errorCount\":\"0\",\"name\":\"Albums by Artist\",\"Release\":[{\"rating\":\"-1\",\"flags\":\"2\",\"title\":\"All I Ever Wanted (Bonus Tracks)\",\"typeID\":\"2\",\"releaseDate\":\"2009-03-09T07:00:00Z\",\"releaseYear\":\"2009\",\"url\":\"http://new.music.yahoo.com/kelly-clarkson/albums/all-i-ever-wanted-bonus-tracks--209579089\",\"id\":\"209579089\",\"rights\":\"160\",\"Artist\":{\"hotzillaID\":\"1808430044\",\"rating\":\"-1\",\"name\":\"Kelly Clarkson\",\"flags\":\"59011\",\"catzillaID\":\"0\",\"trackCount\":\"311\",\"url\":\"http://new.music.yahoo.com/kelly-clarkson/\",\"website\":\"http://www.kellyclarkson.com/\",\"id\":\"295638\"},\"UPC\":\"0886974767725\",\"explicit\":\"0\",\"label\":\"RCA Records Label\"},{\"rating\":\"-1\",\"flags\":\"130\",\"title\":\"Breakaway\",\"typeID\":\"2\",\"releaseDate\":\"2004-01-01T08:00:00Z\",\"releaseYear\":\"2004\",\"url\":\"http://new.music.yahoo.com/kelly-clarkson/albums/breakaway--17965983\",\"id\":\"17965983\",\"rights\":\"0\",\"Artist\":{\"hotzillaID\":\"1808430044\",\"rating\":\"-1\",\"name\":\"Kelly Clarkson\",\"flags\":\"59011\",\"catzillaID\":\"0\",\"trackCount\":\"311\",\"url\":\"http://new.music.yahoo.com/kelly-clarkson/\",\"website\":\"http://www.kellyclarkson.com/\",\"id\":\"295638\"},\"UPC\":\"828766449129\",\"explicit\":\"0\",\"label\":\"RCA/BMG\"}],\"total\":\"49\",\"description\":\"Albums by Artist\",\"start\":\"1\",\"count\":\"2\"}}"

    parsed_input = JSON.parse(json_input)

    @converter = CouchdbConverter.new
    @result = @converter.to_album_document parsed_input
  end

  it "should contain the title of both releases" do
    @result[0].should include("\"title\":\"All I Ever Wanted (Bonus Tracks)\"")
    @result[1].should include("\"title\":\"Breakaway\"")
  end

  it "should contain type 'album'" do
    @result[0].should include("\"type\":\"album\"")
    @result[1].should include("\"type\":\"album\"")
  end
end