# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_mem',
  docs: <<-EOS,
@summary a chaosexperiment_mem type
@example
chaosexperiment_mem { 'foo':
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
      type:    'Optional[String]',
      behaviour: :read_only,
      desc:    '',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    buffer: {
      type:      'Optional[Boolean]',
      desc:      'Ram mode mem-percent is include buffer/cache',
    },
    load: {
      type:      'Optional[Integer]',
      desc:      'percent of burn Memory (0-100)',
    },
    burn_method: {
      type:    'Optional[Enum[cache, ram]]',
      desc:    'burn memory mode, cache or ram',
      default: 'cache',
    },
    rate: {
      type:      'Optional[Integer]',
      desc:      'burn memory rate, unit is M/S, only support for ram mode',
    },
    reserve: {
      type:      'Optional[Integer]',
      desc:      'reserve to burn Memory, unit is MB. If the mem-percent flag exist, use mem-percent first.',
    },
  },
)
