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
        let(:validator) { Indexter::Validator.new('_cats') }

        specify { expect(validator.suffixes).to eq ['_cats'] }
      end
    end

    describe '#exclusions' do
      context 'with defaults' do
        let(:validator) { Indexter::Validator.new }

        specify { expect(validator.exclusions).to eq Indexter::Validator::DEFAULT_EXCLUSIONS }
      end

      context 'with custom' do
        let(:exclusions) { ['table_a', 'table_b'] }
        let(:validator) { Indexter::Validator.new('_id', exclusions) }

        specify { expect(validator.exclusions).to eq exclusions }
      end
    end

    describe '#validate' do
      context 'with defaults' do
        let(:result) { Indexter::Validator.new.validate }

        # Fields that end in _id
        specify { expect(result.fetch('address')).to include 'property_id' }
        specify { expect(result.fetch('address')).not_to include 'user_id' }

        # Fields that end in _uuid
        specify { expect(result.fetch('address')).not_to include 'first_uuid' }
        specify { expect(result.fetch('address')).to include 'second_uuid' }
      end

      context 'with custom suffixes' do
        let(:result) { Indexter::Validator.new('_cats').validate }

        specify { expect(result.fetch('address')).not_to include 'alpha_cats'}
        specify { expect(result.fetch('address')).to include 'beta_cats'}
      end
    end
  end
end
