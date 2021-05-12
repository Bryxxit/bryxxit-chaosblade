# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_process'

RSpec.describe 'the chaosexperiment_process type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_process)).not_to be_nil
  end
end
