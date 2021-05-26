# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_strace',
  docs: <<-EOS,
@summary a chaosexperiment_strace type
@example
chaosexperiment_strace { 'foo':
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
      type:    'Enum[strace_delay, strace_error]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'process_delay',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    delay_loc: {
      type:      'Optional[String]',
      desc:      'if the flag is enter, the fault will be injected before the syscall is executed. if the flag is exit, the fault will be injected after the syscall is executed (required)',
    },
    end: {
      type:      'Optional[String]',
      desc:      'if the flag is set, the fault will be injected to the last met syscall',
    },
    first: {
      type:      'Optional[String]',
      desc:      'if the flag is set, the fault will be injected to the first met syscall',
    },
    step: {
      type:      'Optional[String]',
      desc:      'the fault will be injected intervally',
    },
    syscall_name: {
      type:      'Optional[String]',
      desc:      'The target syscall which will be injected (required)',
    },
    pid: {
      type:      'Optional[Integer]',
      desc:      'The Pid of the target process (required)',
    },
    return_value: {
      type:      'Optional[String]',
      desc:      'the return-value the syscall will return (required for error)',
    },
    time: {
      type:      'Optional[String]',
      desc:      'sleep time, the unit of time can be specified: s,ms,us,ns (required)',
    },
  },
)
