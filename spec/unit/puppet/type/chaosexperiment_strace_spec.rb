# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_strace'

RSpec.describe 'the chaosexperiment_strace type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_strace)).not_to be_nil
  end
end
