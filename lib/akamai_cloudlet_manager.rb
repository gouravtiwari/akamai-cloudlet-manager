require 'akamai_cloudlet_manager/base'
require 'akamai_cloudlet_manager/detail'
require 'akamai_cloudlet_manager/origin'
require 'akamai_cloudlet_manager/policy_version'
require 'akamai_cloudlet_manager/policy'
require 'extensions/exception'

module AkamaiCloudletManager
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.lib
    File.join root, 'lib'
  end

  def self.spec
    File.join root, 'spec'
  end
end