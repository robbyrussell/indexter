require "spec_helper"
require 'indexter'

RSpec.describe Indexter do
  describe '#version' do
    specify { expect(Indexter::VERSION).not_to be nil }
  end

  describe 'Indexter::Validator' do
    describe '#suffixes' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new }

        specify { expect(validator.suffixes).to eq Indexter::Validator::DEFAULT_SUFFIXES }
      end

      context 'with custom' do
        let(:suffixes)  { '_cats' }
        let(:validator) { Indexter::Validator.new(suffixes: suffixes) }

        specify { expect(validator.suffixes).to eq [suffixes] }
      end
    end

    describe '#exclusions' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new }

        specify { expect(validator.exclusions).to eq Indexter::Validator::DEFAULT_EXCLUSIONS }
      end

      context 'with custom' do
        let(:exclusions) { ['table_a', 'table_b'] }
        let(:validator)  { Indexter::Validator.new(suffixes: '_id', exclusions: exclusions) }

        specify { expect(validator.exclusions).to eq exclusions }
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

      context 'with custom suffixes' do
        let(:validator) { Indexter::Validator.new(suffixes: '_cats') }
        let(:result)    { validator.validate }

        specify { expect(result.fetch(:suffixes)).to eq validator.suffixes }
        specify { expect(result.fetch(:exclusions)).to eq validator.exclusions }

        specify { expect(result.fetch(:missing).fetch('addresses')).not_to include 'alpha_cats'}
        specify { expect(result.fetch(:missing).fetch('addresses')).to include 'beta_cats'}
      end
    end
  end
end
