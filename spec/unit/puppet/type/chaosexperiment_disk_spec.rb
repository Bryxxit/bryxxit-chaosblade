# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_disk'

RSpec.describe 'the chaosexperiment_disk type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_disk)).not_to be_nil
  end
end
