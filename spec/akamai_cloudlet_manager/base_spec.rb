require 'spec_helper'


RSpec.describe AkamaiCloudletManager::Base do

  describe '#initialize' do
    subject {
      AkamaiCloudletManager::Base.new({
        path_to_edgerc: AkamaiCloudletManager.spec + '/test_edgerc',
        section:        'test_edgerc'
      })
    }

    describe 'attributes' do
      it 'http_host' do
        p subject.instance_variable_get(:@http_host)
        expect(subject.instance_variable_get(:@http_host).class).to eq(Akamai::Edgegrid::HTTP)
      end

      it 'base_uri' do
        expect(subject.instance_variable_get(:@base_uri).class).to eq(URI::HTTPS)
      end
    end
  end
end
