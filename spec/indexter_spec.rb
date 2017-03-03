require "spec_helper"
require 'indexter'

RSpec.describe Indexter do
  describe '#version' do
    specify { expect(Indexter::VERSION).not_to be nil }
  end

  describe 'Indexter::Validator' do
    describe '.validate' do
      let(:result) { Indexter.validate(config_file_path: './spec/support/config.yaml') }

      specify { puts ">> #{result.inspect}" }

      specify { expect(result.fetch(:missing).fetch('addresses')).to include 'property_id' }
      specify { expect(result.fetch(:missing).fetch('addresses')).not_to include 'first_uuid' }
    end

    describe '#suffixes' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new }

        specify { expect(validator.suffixes).to eq Indexter::Validator::DEFAULT_SUFFIXES }
      end
    end

    describe '#exclusions' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new }

        specify { expect(validator.exclusions).to eq Indexter::Validator::DEFAULT_EXCLUSIONS }
      end
    end

    describe '#validate' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new() }
        let(:result)    { validator.validate }

        specify { expect(result.fetch(:suffixes)).to eq validator.suffixes }
        specify { expect(result.fetch(:exclusions)).to eq validator.exclusions }

        # Fields that end in _id
        specify { expect(result.fetch(:missing).fetch('addresses')).to include 'property_id' }
        specify { expect(result.fetch(:missing).fetch('addresses')).not_to include 'user_id' }

        # Fields that end in _uuid
        specify { expect(result.fetch(:missing).fetch('addresses')).not_to include 'first_uuid' }
        specify { expect(result.fetch(:missing).fetch('addresses')).to include 'second_uuid' }
      end
    end
  end
end
