require 'spec_helper'
require 'indexter/formatters/pass_fail'

describe Indexter::Formatters::PassFail do

  describe '#format' do
    let(:formatter) { Indexter::Formatters::PassFail.new }
    
    context 'with failures' do
      let(:payload) { { missing: ['alpha', 'bravo'] } }

      specify { expect(formatter.format(payload)).to eq 2 }
    end

    context 'with no failures' do
      let(:payload) { { missing: [] } }

      specify { expect(formatter.format(payload)).to eq 0 }
    end
  end

end
