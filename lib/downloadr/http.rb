require 'rest_client'
require 'addressable/uri'

# HTTP/HTTPS Transport handler for downloading a file

module Downloadr
  class HTTP
    attr_reader :uri, :path

    # @param [String] uri
    # @param [String] download_path
    def initialize(uri, download_path = nil)
      @uri = ::Addressable::URI.parse(uri)
      @path = normalize_path(download_path)
    end

    def download
      begin
        response = ::RestClient::Request.execute(
                     :method => :get,
                     :url => @uri.to_s,
                     :timeout => 100,
                     :open_timeout => 10
                   )

      rescue ::SocketError
        raise Downloadr::SocketError
      rescue RestClient::ResourceNotFound
        raise Downloadr::ResourceNotFound
      end

      File.write(@path, response.to_str)
    end

    def self.download(uri, download_path = nil)
      downloader = Downloadr::HTTP.new(uri, download_path)
      downloader.download
    end

    private
    def normalize_path(download_path)
      if download_path.nil?
        if @uri.basename.empty? ||
           @uri.basename.nil?
          raise Downloadr::UnknownDownloadPath
        else
          path = @uri.basename
        end
      else
        path = download_path
      end

      return path
    end

  end
end