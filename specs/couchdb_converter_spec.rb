require "spec"
$: << 'src/'
require "couchdb_converter"

describe "Convert artist to CouchDB format" do
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


  # "Name":
    # "type": "artist"
    # "Website":
    # "Tags" ["Popular"]
    # "Photos" []
end