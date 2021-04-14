# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment',
  docs: <<-EOS,
@summary a chaosexperiment type
@example
chaosexperiment { 'foo':
  ensure => 'present',
}

This type provides Puppet with the capabilities to manage ...

If your type uses autorequires, please document as shown below, else delete
these lines.
**Autorequires**:
* `Package[foo]`
EOS
  features: [],
  attributes: {
    ensure: {
      type:    'Enum[present, absent]',
      desc:    'Whether this resource should be present or absent on the target system.',
      default: 'present',
    },
    name: {
      type:      'String',
      desc:      'The uid for the attack',
      behaviour: :namevar,
    },
    type: {
      type:    'Enum[cpu, disk_burn, disk_fill, mem, file]',
      desc:    'The type of attack you would like to trigger.',
      default: 'cpu',
    },
    load: {
      type:      'Optional[Integer]',
      desc:      'cpu load percentage in procent',
    },
    climb: {
      type:      'Optional[Integer]',
      desc:      'The climb time in seconds for the attack',
    },
    cpu_count: {
      type:      'Optional[Integer]',
      desc:      'The number of cpu\'s to use in the attack',
    },
    cpu_list: {
      type:      'Optional[string]',
      desc:      'CPUs in which to allow burning (0-3 or 1,3)',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the attack',
    },
    # recreate: {
    #   type:      'Boolean',
    #   desc:      'Whether to recreate the attack if status is destroyed',
    #   default:   true,
    # },

  },
)
