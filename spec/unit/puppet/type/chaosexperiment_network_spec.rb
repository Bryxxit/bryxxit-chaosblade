# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_network'

RSpec.describe 'the chaosexperiment_network type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_network)).not_to be_nil
  end
end
