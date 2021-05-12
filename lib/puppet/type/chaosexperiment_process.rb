# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_process',
  docs: <<-EOS,
@summary a chaosexperiment_process type
@example
chaosexperiment_process { 'foo':
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
      desc:      'The name of the resource you want to manage.',
      behaviour: :namevar,
    },
    type: {
      type:    'Enum[process_kill, process_stop]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'process_kill',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    count: {
      type:      'Optional[Integer]',
      desc:      'limit count 0 means unlimited',
    },
    ignore_not_found: {
      type:      'Optional[Boolean]',
      desc:      'Ignore process that cannot be found',
    },
    local_port: {
      type:      'Optional[String]',
      desc:      'Local service ports. Separate multiple ports with commas (,) or connector representing ranges, for example: 80,8000-8080',
    },
    process: {
      type:      'Optional[String]',
      desc:      'Process name',
    },
    process_cmd: {
      type:      'Optional[String]',
      desc:      'process name in command',
    },
    signal: {
      type:      'Optional[Integer]',
      desc:      'Killing process signal, such as 9,15',
    },
  },
)
