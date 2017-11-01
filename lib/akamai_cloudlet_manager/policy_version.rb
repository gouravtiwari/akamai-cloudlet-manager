module AkamaiCloudletManager
  class PolicyVersion < Base
    def initialize(options = {})
      @policy_id  = options[:policy_id]
      @version_id = options[:version_id]
      super
    end

    # Get Policy version's rules
    # request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/policies/38548/versions/1?omitRules=false&matchRuleFormat=1.0"').to_s
    def rules
      request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/policies/#{@policy_id}/versions/#{@version_id}?omitRules=false&matchRuleFormat=1.0").to_s
      response = @http_host.request(request)
      # puts response.body
      response.body
    end


    # Get policy versions
    def versions
      request  = Net::HTTP::Get.new URI.join(
        @base_uri.to_s,
        "cloudlets/api/v2/policies/#{@policy_id}/versions?includeRules=false&matchRuleFormat=1.0"
      ).to_s
      response = @http_host.request(request)
      # puts response.body
      response.body
    end

    # Create a policy version
    def create(clone_from_version_id)
      request  = Net::HTTP::Post.new(
        URI.join(
          @base_uri.to_s,
          "cloudlets/api/v2/policies/#{@policy_id}/versions?includeRules=false&matchRuleFormat=1.0&cloneVersion=#{clone_from_version_id}"
        ).to_s,
        { 'Content-Type' => 'application/json'}
      )
      response = @http_host.request(request)
      # puts response.body
      response.body
    end

    # Activate a policy version
    def activate(network)
      request  = Net::HTTP::Post.new(
        URI.join(
          @base_uri.to_s,
          "/cloudlets/api/v2/policies/#{@policy_id}/versions/#{@version_id}/activations"
        ).to_s,
        { 'Content-Type' => 'application/json'}
      )
      request.body = {
        "network": network
      }.to_json
      response = @http_host.request(request)
      # puts response.body
      response.body
    end

    # Update policy version, all rules
    def update(policy_version_rules)
      request = Net::HTTP::Put.new(
          URI.join(@base_uri.to_s, "cloudlets/api/v2/policies/#{@policy_id}/versions/#{@version_id}?omitRules=false&matchRuleFormat=1.0").to_s,
          { 'Content-Type' => 'application/json'}
        )
      # ToDo: This need to be dynamic
      request.body = policy_version_rules
      response = @http_host.request(request)
      # puts response.body
      response.body
    end

    def generate_rules(file_path)
      counter = 1
      begin
          file = File.new(file_path, "r")
          while (line = file.gets)
              puts "#{counter}: #{line}"
              counter = counter + 1
          end
          file.close
      rescue => err
          puts "Exception: #{err}"
          err
      end
    end

  end
end
