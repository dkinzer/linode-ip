# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength
RSpec.describe Linode::Ip do
  subject { Class.extend(Linode::Ip) }

  it 'has a version number' do
    expect(Linode::Ip::VERSION).not_to be nil
  end

  before do
    allow(subject).to receive(:linodes) { linodes }
    allow(subject).to receive(:select_linodes_index) { selection }
    allow(subject).to receive(:read_matcher) { matcher }
  end

  context 'linodes is empty' do
    let(:linodes) { [] }

    it 'does not fetch any ips' do
      expect(subject.fetch('foo')).to be_nil
    end
  end

  context 'linodes does not have a match' do
    let(:linodes) { [{ 'label' => 'bar' }] }

    it 'does not fetch any ips' do
      expect(subject.fetch('foo')).to be_nil
    end
  end

  context 'linodes has a single matching node' do
    let(:linodes) { [{ 'label' => 'foo', 'ipv4' => ['host.ip'] }] }

    it 'fetches the ip' do
      expect(subject.fetch('foo')).to eq('host.ip')
    end
  end

  context 'there are multiple matching linodes' do
    let(:linodes) do
      [{ 'label' => 'foo0', 'ipv4' => ['host.ip0'] },
       { 'label' => 'foo1', 'ipv4' => ['host.ip1'] },
       { 'label' => 'foo2', 'ipv4' => ['host.ip2'] }]
    end

    let(:selection) { 1 }

    it 'fetches the selected linode ip' do
      expect(subject.fetch('foo')).to eq('host.ip1')
    end
  end

  context 'we choose to update the matcher with single match' do
    let(:linodes) do
      [{ 'label' => 'foo0', 'ipv4' => ['host.ip0'] },
       { 'label' => 'foo1', 'ipv4' => ['host.ip1'] },
       { 'label' => 'bar', 'ipv4' => ['host.ipbar'] }]
    end

    let(:selection) { 'u' }
    let(:matcher) { 'bar' }

    it 'fetches the newly matched linode' do
      expect(subject.fetch('foo')).to eq('host.ipbar')
    end
  end

  context 'we choose to update the matcher with no match' do
    let(:linodes) do
      [{ 'label' => 'foo0', 'ipv4' => ['host.ip0'] },
       { 'label' => 'foo1', 'ipv4' => ['host.ip1'] },
       { 'label' => 'bar', 'ipv4' => ['host.ipbar'] }]
    end

    let(:selection) { 'u' }
    let(:matcher) { 'buzz' }

    it 'fetches the newly matched linode' do
      expect(subject.fetch('foo')).to be_nil
    end
  end
end
# rubocop: enable Metrics/BlockLength
