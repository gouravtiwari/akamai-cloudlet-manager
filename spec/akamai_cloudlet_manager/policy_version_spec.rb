require 'spec_helper'


RSpec.describe AkamaiCloudletManager::PolicyVersion do

  describe '#initialize' do
    subject { AkamaiCloudletManager::PolicyVersion.new({ policy_id: '123', version_id: '456' }) }

    context 'attributes' do
      it 'policy_id' do
        expect(subject.instance_variable_get(:@policy_id)).to eq('123')
      end

      it 'version_id' do
        expect(subject.instance_variable_get(:@version_id)).to eq('456')
      end
    end
  end
end
