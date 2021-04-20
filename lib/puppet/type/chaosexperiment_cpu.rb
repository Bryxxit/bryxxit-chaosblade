# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_cpu',
  docs: <<-EOS,
@summary a chaosexperiment_cpu type
@example
chaosexperiment_cpu { 'foo':
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
      desc:      'The uid for the experiment',
      behaviour: :namevar,
    },
    type: {
      type:    'Enum[cpu, disk_burn, disk_fill, mem, file_add]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'cpu',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    ### Cpu params
    load: {
      type:      'Optional[Integer]',
      desc:      'cpu load percentage in procent',
    },
    climb: {
      type:      'Optional[Integer]',
      desc:      'The climb time in seconds for the experiment',
    },
    cpu_count: {
      type:      'Optional[Integer]',
      desc:      'The number of cpus to use in the experiment',
    },
    cpu_list: {
      type:      'Optional[String]',
      desc:      'CPUs in which to allow burning (0-3 or 1,3)',
    },
  },
)
