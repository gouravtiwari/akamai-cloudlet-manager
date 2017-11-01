require 'spec_helper'


RSpec.describe AkamaiCloudletManager::Policy do

  describe '#initialize' do
    subject {
      AkamaiCloudletManager::Policy.new({
        path_to_edgerc: AkamaiCloudletManager.spec + '/test_edgerc',
        section:        'test_edgerc',
        policy_id:      '123'
      })
    }

    context 'attributes' do
      it 'policy_id' do
        expect(subject.instance_variable_get(:@policy_id)).to eq('123')
      end
    end
  end
end
