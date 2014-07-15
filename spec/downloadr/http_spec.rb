require 'downloadr'
require 'tempfile'

module Downloader
  describe "HTTP" do
  	context "when initializing Downloadr::HTTP" do
  		before :each do
				@download_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  			@http_downloadr = Downloadr::HTTP.new(@uri, @download_path)
  		end

  		subject{@http_downloadr}

  		it {should be_kind_of Downloadr::HTTP}

  		it "should have the right uri" do
  			expect(subject.uri).to eql(::Addressable::URI.parse(@uri))
  		end

  		it "should have the right file path" do
  			expect(subject.path).to be(@download_path)
  		end
  	end

    context "when initializing Downloadr::HTTP w/o a download path" do
      before :each do
        @uri = "http://www.google.com/index.html"
        @http_downloadr = Downloadr::HTTP.new(@uri)
      end

      subject{@http_downloadr}

      it {should be_kind_of Downloadr::HTTP}

      it "should have the right uri" do
        expect(subject.uri).to eql(::Addressable::URI.parse(@uri))
      end

      it "should have the right file path" do
        expect(subject.path).to eql("index.html")
      end
    end

    context "when initializing Downloadr::HTTP w/o a download path or uri filename" do
      before :each do
        @uri = "http://www.google.com"
      end

      subject{@http_downloadr}

      it "should have the right uri" do
        expect {
          Downloadr::HTTP.new(@uri) 
        }.to raise_error(Downloadr::UnknownDownloadPath)
      end
    end


  	context "when downloading a file via HTTP" do
  		before :each do
				@download_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  			@http_downloadr = Downloadr::HTTP.new(@uri, @download_path)
  		end

  		subject{@http_downloadr}

  		it "should start with an empty file" do
  			expect(subject.path.size).to be(0)
  		end

  		it "should return a Fixnum when being downloaded" do
  			expect(subject.download).to be_kind_of ::Fixnum
  		end

  		it "should have created a file on disk" do
  			subject.download
  			expect(subject.path.size).to be > 0
  		end

  		it "should have content that looks like google" do
  			subject.download
  			expect(File.read(subject.path)).to include("google")
  		end
  	end

  	context "when downloading via self.download" do
  		before :each do
  			@download_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  		end

  		it "should start with an empty file" do
  			expect(@download_path.size).to be(0)
  		end

  		it "should return a Fixnum when being downloaded" do
  			expect(Downloadr::HTTP.download(@uri, @download_path)).to be_kind_of ::Fixnum
  		end

  		it "should have created a file on disk" do
  			Downloadr::HTTP.download(@uri, @download_path)
  			expect(@download_path.size).to be > 0
  		end

  		it "should have content that looks like google" do
  			Downloadr::HTTP.download(@uri, @download_path)
  			expect(File.read(@download_path)).to include("google")
  		end
  	end

    context "when attempting to download from a uri that returns a 404" do
      before :each do
        @download_path = Tempfile.new('downloadr')
        @uri = "http://www.google.com/this_file_does_not_exist"
      end

      it "should start with an empty file" do
        expect(@download_path.size).to be(0)
      end

      it "should throw an exception when attempting to download" do
        expect {
          Downloadr::HTTP.download(@uri, @download_path)
        }.to raise_error(Downloadr::ResourceNotFound)
      end

      it "should not have created a file on disk" do
        expect {
          Downloadr::HTTP.download(@uri, @download_path)
        }.to raise_error(Downloadr::ResourceNotFound)
        expect(@download_path.size).to be(0)
      end
    end

    context "when attempting to download from a uri that doesn't resolve" do
      before :each do
        @download_path = Tempfile.new('downloadr')
        @uri = "http://abc.local/this_server_does_not_exist"
      end

      it "should start with an empty file" do
        expect(@download_path.size).to be(0)
      end

      it "should throw an exception when attempting to download" do
        expect {
          Downloadr::HTTP.download(@uri, @download_path)
        }.to raise_error(Downloadr::SocketError)
      end

      it "should not have created a file on disk" do
        expect {
          Downloadr::HTTP.download(@uri, @download_path)
        }.to raise_error(Downloadr::SocketError)
        expect(@download_path.size).to be(0)
      end
    end    

  end
end