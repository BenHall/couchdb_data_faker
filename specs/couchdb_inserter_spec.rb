require "spec"
require 'fakeweb'
$: << 'src/'
require "couchdb_inserter"

describe "Put documents" do
  before(:all) do
    @json = ""
    FakeWeb.register_uri(:put, "http://couchdb1:5984/product_catalog", :body => @json)
  end

  it "should send a put request with json" do
    #curl -X PUT http://127.0.0.1:5984/albums/6e1295ed6c29495e54cc05947f18c8af -d '{"title":"There is Nothing Left to Lose","artist":"Foo Fighters"}'

    inserter = CouchdbInserter.new
    result = inserter.put @json
    result.should_not be_nil
  end
end