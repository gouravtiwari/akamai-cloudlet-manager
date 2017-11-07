module AkamaiCloudletManager
  class Detail < Base

    def initialize(options = {})
      @cloudlet_id  = options[:cloudlet_id]
      @group_id     = options[:group_id]
      super
    end

    # Get a cloudlet info
    def info
      request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/cloudlet-info/#{@cloudlet_id}").to_s
      response = @http_host.request(request)
      response.body
    end

    # Get a list of cloudlets in a group
    def list
      request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/cloudlet-info?#{@group_id}").to_s
      response = @http_host.request(request)
      response.body
    end
  end
end
