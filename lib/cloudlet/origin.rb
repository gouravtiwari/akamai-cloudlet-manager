module Cloudlet
  class Origin < Base
    # List cloudlet Origins
    # @type this is origin type, e.g. APPLICATION_LOAD_BALANCER
    def list(type)
      request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/origins?type=#{type}").to_s
      response = @http_host.request(request)
      # puts response.body
      response.body
    end
  end
end