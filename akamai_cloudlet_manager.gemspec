Gem::Specification.new do |s|
  s.name        = 'akamai_cloudlet_manager'
  s.version     = '0.0.1'
  s.date        = '2017-10-27'
  s.summary     = "Akamai Cloudlet Manager"
  s.description = "Akamai Cloudlet Manager manages all the cloudlet api."
  s.authors     = ["Gourav Tiwari","Ankit Gupta"]
  s.email       = ["gouravtiwari21@gmail.com","ankit.gupta8898@gmail.com"]
  s.files       = ["lib/akamai_cloudlet_manager.rb",
                   "lib/akamai_cloudlet_manager/base.rb",
                   "lib/akamai_cloudlet_manager/detail.rb",
                   "lib/akamai_cloudlet_manager/origin.rb",
                   "lib/akamai_cloudlet_manager/policy_version.rb",
                   "lib/akamai_cloudlet_manager/policy.rb"
                 ]
  s.executables << 'ac'
  s.homepage    = 'https://github.com/gouravtiwari/akamai-cloudlet-manager'
  s.license       = 'MIT'
  s.add_runtime_dependency 'akamai-edgegrid', '~> 1.0', '>= 1.0.6'
  s.add_runtime_dependency 'json', '~> 2.1'
  s.add_runtime_dependency 'thor', '~> 0.20.0'
  s.add_development_dependency 'rspec', '~> 3.7'
end
