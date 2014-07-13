require 'downloadr'
require 'tempfile'

module Downloader
  describe "HTTP" do
  	context "when initializing Downloadr::HTTP" do
  		before :each do
				@file_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  			@http_downloadr = Downloadr::HTTP.new(@uri, @file_path)
  		end

  		subject{@http_downloadr}

  		it { should be_kind_of Downloadr::HTTP}

  		it "should have the right uri" do
  			expect(subject.uri).to be(@uri)
  		end

  		it "should have the right file path" do
  			expect(subject.path).to be(@file_path)
  		end
  	end

  	context "when downloading a file via HTTP" do
  		before :each do
				@file_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  			@http_downloadr = Downloadr::HTTP.new(@uri, @file_path)
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
  			@file_path = Tempfile.new('downloadr')
				@uri = "http://www.google.com/index.html"
  		end

  		it "should start with an empty file" do
  			expect(@file_path.size).to be(0)
  		end

  		it "should return a Fixnum when being downloaded" do
  			expect(Downloadr::HTTP.download(@uri, @file_path)).to be_kind_of ::Fixnum
  		end

  		it "should have created a file on disk" do
  			Downloadr::HTTP.download(@uri, @file_path)
  			expect(@file_path.size).to be > 0
  		end

  		it "should have content that looks like google" do
  			Downloadr::HTTP.download(@uri, @file_path)
  			expect(File.read(@file_path)).to include("google")
  		end
  	end
  end
end