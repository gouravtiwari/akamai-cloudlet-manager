module AkamaiCloudletManager
  class PolicyVersion < Base
    def initialize(options = {})
      @policy_id  = options[:policy_id]
      @version_id = options[:version_id]
      super
    end

    # Get Policy version's rules
    def existing_rules
      request  = Net::HTTP::Get.new URI.join(@base_uri.to_s, "cloudlets/api/v2/policies/#{@policy_id}/versions/#{@version_id}?omitRules=false&matchRuleFormat=1.0").to_s
      response = @http_host.request(request)
      response.body
    end


    # Get policy versions
    def versions
      request  = Net::HTTP::Get.new URI.join(
        @base_uri.to_s,
        "cloudlets/api/v2/policies/#{@policy_id}/versions?includeRules=false&matchRuleFormat=1.0"
      ).to_s
      response = @http_host.request(request)
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
      response.body
    end

    def append(options={})
      # Removing location is mandatory from matchRules, otherwise we see this error:
      # matchRules : object instance has properties which are not allowed by the schema: [\"location\"]\n"
      rules = JSON.parse(existing_rules)
      rules = rules["matchRules"].map{|rule| rule.delete('location'); rule; }

      update(options, rules)
    end

    # Update policy version, all rules
    def update(options = {}, existing_rules = [])

      request = Net::HTTP::Put.new(
          URI.join(@base_uri.to_s, "cloudlets/api/v2/policies/#{@policy_id}/versions/#{@version_id}?omitRules=false&matchRuleFormat=1.0").to_s,
          { 'Content-Type' => 'application/json'}
        )
      rules = generate_path_rules(options) + generate_cookie_rules(options) + existing_rules

      if rules.empty?
        puts "No rules to apply, please check syntax"
        return
      end

      request.body =  {
                        matchRules: rules
                      }.to_json
      response = @http_host.request(request)
      response.body
    end

    # All the path rules from one file will be added under same match, space separated
    def generate_path_rules(options={})
      return [] if options[:file_path].nil? || options[:file_path].empty?

      options     = options.merge(match_operator: 'contains', match_type: 'path')
      counter     = 0
      match_value = []

      file = File.new(options[:file_path], "r")
      while (line = file.gets)
        match_value << line
        counter += 1
      end
      file.close

      puts "Total rules read from file: #{counter}\n"

      match_value = match_value.join(' ').gsub(/\n/, '')

      match_rules(match_value, options)
    rescue => err
      puts "Exception: #{err.formatted_exception("Path rules generation failed!")}"
      err
    end

    # All the path rules from one file will be added under same match, space separated
    def generate_cookie_rules(options = {})
      return [] if options[:cookie_rules].nil? || options[:cookie_rules].empty?

      options = options.merge(match_operator: 'contains', match_type: 'cookie')

      match_rules(options[:cookie_rules], options)
    rescue => err
      puts "Exception: #{err.formatted_exception("Cookie rules generation failed!")}"
      err
    end

    private

    def match_rules(match_value, options)
      [{
        type:     options[:rule_type] || 'albMatchRule',
        id:       0,
        name:     options[:rule_name],
        start:    0,
        end:      0,
        matchURL: nil,
        matches:  [{
          matchValue:    match_value,
          matchOperator: options[:match_operator],
          negate:        false,
          caseSensitive: false,
          matchType:     options[:match_type]
        }],
        forwardSettings: {
          originId: options[:origin_id]
        }
      }]
    end
  end
end
