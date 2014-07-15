require 'rest_client'
require 'addressable/uri'

# HTTP/HTTPS Transport handler for downloading a file

module Downloadr
  class HTTP
    attr_reader :uri, :path

    # @param [String] uri
    # @param [String] download_path
    def initialize(uri, download_path)
      @uri = ::Addressable::URI.parse(uri)
      @path = download_path
    end

    def download(opts = {})
      response = ::RestClient::Request.execute(
                   :method => :get,
                   :url => @uri.to_s,
                   :timeout => 10,
                   :open_timeout => 10
                 )

      File.write(@path, response.to_str)
    end

    def self.download(uri, download_path)
      downloader = Downloadr::HTTP.new(uri, download_path)
      downloader.download
    end
  end
end