require 'spec_helper'
require 'indexter/null_config'

describe NullConfig do
  describe '#format' do
    specify { expect(NullConfig.new.format).to eq nil }
    specify { expect(NullConfig.new.exclusions).to eq nil }
    specify { expect(NullConfig.new.suffixes).to eq nil }
  end
end
