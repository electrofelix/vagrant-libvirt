require 'spec_helper'
require 'support/sharedcontext'

require 'vagrant-libvirt/action/clean_machine_folder'

describe VagrantPlugins::ProviderLibvirt::Action::PackageDomain do
  subject { described_class.new(app, env) }

  include_context 'unit'
  include_context 'libvirt'

  let(:libvirt_client) { double('libvirt_client') }
  let(:servers) { double('servers') }
  let(:volumes) { double('volumes') }

  describe '#call' do
    before do
      allow_any_instance_of(VagrantPlugins::ProviderLibvirt::Driver)
        .to receive(:connection).and_return(connection)
      allow(connection).to receive(:client).and_return(libvirt_client)
      allow(libvirt_client).to receive(:lookup_domain_by_uuid).and_return(libvirt_domain)

      allow(connection).to receive(:servers).and_return(servers)
      allow(servers).to receive(:get).and_return(domain)

      allow(connection).to receive(:volumes).and_return(volumes)

      allow(logger).to receive(:info)
    end

    context 'with defaults' do
      before do
      end

      it 'should succeed' do
        subject.call(env).to be_nil
      end
    end
  end
end
