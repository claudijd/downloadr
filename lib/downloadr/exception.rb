module Downloadr
  class ResourceNotFound < StandardError
  end

  class UnknownDownloadPath < StandardError
  end

  class SocketError < StandardError
  end
end