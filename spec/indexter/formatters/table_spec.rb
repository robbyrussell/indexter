require 'spec_helper'
require 'indexter/formatters/table'

describe Indexter::Formatters::Table do

  describe '#format' do
    let(:formatter) { Indexter::Formatters::Table.new }

    context 'with failure' do
      let(:payload) { { missing: { cats: ['alpha', 'bravo'] } } }

      specify { expect(formatter.format(payload).to_s).to include 'alpha' }
      specify { expect(formatter.format(payload).to_s).to include 'bravo' }
    end

    context 'without failure' do
      let(:payload) { { missing: []} }

      specify { expect(formatter.format(payload).to_s.size).to eq  101 }
    end
  end

end
