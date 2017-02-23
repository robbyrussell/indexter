require 'spec_helper'
require 'indexter/formatters/json'

describe Indexter::Formatters::Json do

  describe '#format' do
    let(:formatter) { Indexter::Formatters::Json.new }

    context 'with failure' do
      let(:payload) { { missing: { cats: ['alpha', 'bravo'] } } }

      specify { expect(formatter.format(payload).to_s).to include 'alpha' }
      specify { expect(formatter.format(payload).to_s).to include 'bravo' }
    end

    context 'without failure' do
      let(:payload) { { missing: []} }

      specify { expect(formatter.format(payload).to_s.size).to eq  14 }
    end
  end

end
