require 'spec_helper'
require 'indexter/formatters/hash'

describe Indexter::Formatters::Hash do

  describe '#format' do
    let(:formatter) { Indexter::Formatters::Hash.new }

    context 'with failures' do
      let(:payload) { { missing: ['alpha', 'bravo'] } }

      specify { expect(formatter.format(payload[:missing]).count).to eq 2 }
    end

    context 'without failures' do
      let(:payload) { { missing: [] } }

      specify { expect(formatter.format(payload[:missing]).count).to eq 0 }
    end
  end

end
