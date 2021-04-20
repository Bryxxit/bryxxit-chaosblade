# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/chaosexperiment_file'

RSpec.describe 'the chaosexperiment_file type' do
  it 'loads' do
    expect(Puppet::Type.type(:chaosexperiment_file)).not_to be_nil
  end
end
