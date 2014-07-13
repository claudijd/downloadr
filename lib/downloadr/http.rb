require "net/http"
require "uri"

module Downloadr
  # HTTP/HTTPS Transport handler for downloading a file
  class HTTP
  	attr_reader :uri, :path

  	# @param [String] uri
  	# @param [String] path
  	def initialize(uri, path)
  	  @uri = uri
  	  @path = path
  	end

  	def download
  	  File.write(
  	  	@path,
  	  	Net::HTTP.get(
  	  	  URI.parse(@uri)
  	  	)
  	  )
  	end

  	def self.download(uri, path)
  	  downloader = Downloadr::HTTP.new(uri, path)
  	  downloader.download
  	end
  end
end