require 'spec_helper'
require 'indexter/config'

describe Indexter::Config do

  describe '#initialize' do
    context 'with default config' do
      specify { expect(Indexter::Config.new.config_file_path).to eq Indexter::Config::DEFAULT_CONFIG_FILE }
    end

    context 'with custom config' do
      let(:custom_config) { './spec/support/config.yaml' }
      let(:config) { Indexter::Config.new(config_file_path: custom_config) }

      specify { expect(config.config_file_path).to eq custom_config }
      specify { expect(config.exclusions).to       eq({ 'addresses' => ['property_id', 'beta_cats'] }) }
      specify { expect(config.suffixes).to         eq(['_id', '_uuid', '_stuff']) }
    end
  end

  describe '#exists?' do
    let(:config) { Indexter::Config.new }

    context 'when exists' do
      before { FileUtils.touch(Indexter::Config::DEFAULT_CONFIG_FILE) }

      specify { expect(config.exists?).to eq true }
    end

    context 'when not exists' do
      before { FileUtils.rm(Indexter::Config::DEFAULT_CONFIG_FILE) }

      specify { expect(config.exists?).to eq false }
    end
  end

end
