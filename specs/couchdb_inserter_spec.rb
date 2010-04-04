require "spec"
require 'fakeweb'
$: << 'src/'
require "couchdb_inserter"

describe "Put documents" do
  before(:all) do
    @json = "{\"id\":\"1\", \"name\":\"test\"}"
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:put, "http://192.168.1.66:5984/product_catalog/1", :body => @json)
    FakeWeb.register_uri(:put, "http://192.168.1.66:5984/product_catalog", :body => "")
  end

  after(:all) do
    FakeWeb.allow_net_connect = true
  end

  it "should send a put request with json" do
    #curl -X PUT http://127.0.0.1:5984/albums/6e1295ed6c29495e54cc05947f18c8af -d '{"title":"There is Nothing Left to Lose","artist":"Foo Fighters"}'

    inserter = CouchdbInserter.new
    result = inserter.put @json
    result.should_not be_nil
  end

  it "should create a database" do
    inserter = CouchdbInserter.new
    result = inserter.create_db
    result.should_not be_nil
  end

end