require "spec_helper"
require 'indexter'

RSpec.describe Indexter do
  describe '#version' do
    specify { expect(Indexter::VERSION).not_to be nil }
  end

  describe 'Indexter::Validator' do
    describe '#validate' do
      let(:result) { Indexter::Validator.new.validate }

      # Fields that end in _id
      specify { expect(result.fetch('address')).to include 'property_id' }
      specify { expect(result.fetch('address')).not_to include 'user_id' }

      # Fields that end in _uuid
      specify { expect(result.fetch('address')).not_to include 'first_uuid' }
      specify { expect(result.fetch('address')).to include 'second_uuid' }
    end
  end
end
