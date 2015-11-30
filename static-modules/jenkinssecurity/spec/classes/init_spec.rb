require 'spec_helper'
describe 'jenkins' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins') }
  end
end
