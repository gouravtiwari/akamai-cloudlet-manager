require 'spec_helper'


RSpec.describe AkamaiCloudletManager::Detail do

  describe '#initialize' do

    subject {
      AkamaiCloudletManager::Detail.new({
        path_to_edgerc: AkamaiCloudletManager.spec + '/test_edgerc',
        section:        'test_edgerc',
        cloudlet_id:    '123',
        group_id:       '456'
      })
    }

    describe 'attributes' do
      it 'cloudlet_id' do
        expect(subject.instance_variable_get(:@cloudlet_id)).to eq('123')
      end

      it 'group_id' do
        expect(subject.instance_variable_get(:@group_id)).to eq('456')
      end
    end
  end
end
