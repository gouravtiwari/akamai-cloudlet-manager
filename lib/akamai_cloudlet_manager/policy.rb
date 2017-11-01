module AkamaiCloudletManager
  class Policy < Base
    def initialize(options = {})
      @policy_id  = options[:policy_id]
      super
    end

    # Get Associated Properties for a Policy
    def properties
      request  = Net::HTTP::Get.new URI.join(
        @base_uri.to_s,
        "/cloudlets/api/v2/policies/#{@policy_id}/properties"
      ).to_s
      response = @http_host.request(request)
      # puts response.body
      response.body
    end
  end
end
