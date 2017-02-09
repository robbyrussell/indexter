require "spec_helper"
require 'indexter'

RSpec.describe Indexter do
  describe '#version' do
    specify { expect(Indexter::VERSION).not_to be nil }
  end

  describe 'Indexter::Validator' do
    describe '#validate' do
      context 'with no missing indexes' do

        specify { expect(Indexter::Validator.new.validate).to be_empty }
      end

      context 'with missing indexes' do

        specify { expect(Indexter::Validator.new.validate).not_to be_empty }
      end
    end
  end
end
