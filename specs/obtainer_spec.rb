require "spec"
$: << 'src/'
require "obtainer"

describe Obtainer do
  describe "Pull artists" do
    before(:all) do
      @obtainer = Obtainer.new
      @result = @obtainer.get_popular_artists()
    end

    it "should not contain an error" do
      @result.has_key?('Error').should be_false
    end

    it "should return 100 artists from api" do
      @result['Artists']['Artist'].length.should == 100
    end

    it "should be able to join results together" do
      @extra = @obtainer.get_popular_artists(10, 100)
      final = @obtainer.join_results(@result['Artists']['Artist'], @extra['Artists']['Artist'])

      final.length.should == 110
    end
  end

  describe "Pull similar artists" do
    before() do
      @obtainer = Obtainer.new
      @artists = @obtainer.get_popular_artists()['Artists']['Artist']

      @artist = nil
      @artists.each { |a| @artist = a; break }      
    end

    it "should get 100 similar artists based on 1 initial artist" do
      @result = @obtainer.get_similar_artists(@artist)
      @result['Artists']['Artist'].length.should == 100
    end
  end

  describe "Authenication with API" do
    it "should return the key from the yml" do
      obtainer = Obtainer.new
      result = obtainer.get_key()

      result.should =~ /^K7eNhh(.+)/
    end
  end
end