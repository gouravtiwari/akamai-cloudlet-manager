require 'akamai/edgegrid'
require 'net/http'
require 'uri'
require 'json'

module AkamaiCloudletUpdater
  class Base
    def initialize(options = {})
      @http_host = Akamai::Edgegrid::HTTP.new(get_host(), 443)
      @base_uri  = URI('https://' + @http_host.host)

      @http_host.setup_from_edgerc({ section: 'default' })
    end
  end
end
