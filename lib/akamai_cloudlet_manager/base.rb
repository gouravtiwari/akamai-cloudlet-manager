require 'akamai/edgegrid'
require 'net/http'
require 'uri'
require 'json'

module AkamaiCloudletManager
  class Base
    def initialize(options = {})
      path_to_edgerc = options[:path_to_edgerc] || '~/.edgerc'
      section        = options[:section] || 'default'

      @http_host = Akamai::Edgegrid::HTTP.new(get_host(path_to_edgerc, section), 443)
      @base_uri  = URI('https://' + @http_host.host)

      @http_host.setup_from_edgerc({ section: 'default' })
    end
  end
end
