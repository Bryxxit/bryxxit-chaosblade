# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_cpu'

RSpec.describe 'the chaosexperiment_cpu type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_cpu)).not_to be_nil
  end
end
