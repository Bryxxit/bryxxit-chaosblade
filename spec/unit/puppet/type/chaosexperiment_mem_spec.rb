# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_mem'

RSpec.describe 'the chaosexperiment_mem type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_mem)).not_to be_nil
  end
end
