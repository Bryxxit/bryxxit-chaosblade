# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment'

RSpec.describe 'the chaosexperiment type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment)).not_to be_nil
  end
end
