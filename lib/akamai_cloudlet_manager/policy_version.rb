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
    def update(policy_version_rules = {})
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

    def generate_path_rules(file_path, options={})
      rule_type      = options[:rule_type] || 'albMatchRule'
      rule_name      = options[:rule_name]
      origin_id      = options[:origin_id]
      match_operator = options[:match_operator] || 'equals'
      match_type     = 'path'

      counter = 0
      match_value = []
      begin
        file = File.new(file_path, "r")
        while (line = file.gets)
            puts "#{counter}: #{line}"
            match_value << line
            counter += 1
        end

        match_value = match_value.join(' ').gsub(/\n/, '')
        file.close

        rules = {
                  matchRules:[{
                    type:     rule_type,
                    id:       0,
                    name:     rule_name,
                    start:    0,
                    end:      0,
                    matchURL: nil,
                    matches:  [{
                      matchValue:    match_value,
                      matchOperator: match_operator,
                      negate:        false,
                      caseSensitive: false,
                      matchType:     match_type
                    }],
                    forwardSettings: {
                      originId: origin_id
                    }
                  }]
                }
        puts rules
      rescue => err
          puts "Exception: #{err}"
          err
      end
    end

  end
end
