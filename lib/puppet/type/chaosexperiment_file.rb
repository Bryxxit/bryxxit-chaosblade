# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_file',
  docs: <<-EOS,
@summary a chaosexperiment_file type
@example
chaosexperiment_file { 'foo':
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
      type:    'Enum[file_add, file_append, file_chmod, file_delete, file_move]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'file_add',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    count: {
      type:      'Optional[Integer]',
      desc:      'the number of append count, default 1',
    },
    interval: {
      type:      'Optional[Integer]',
      desc:      'append interval, default 1s',
    },
    path: {
      type:      'Optional[String]',
      desc:      'Name or path of the file.',
    },
    content: {
      type:      'Optional[String]',
      desc:      'Content to fill the file with',
    },
    create_dir: {
      type:      'Optional[Boolean]',
      desc:      'Creates directory if it does not exist',
    },
    enable_base64: {
      type:      'Optional[Boolean]',
      desc:      'Use base64 encoding',
    },
    directory: {
      type:      'Optional[Boolean]',
      desc:      'Wether the file created is a directory or not',
    },
    escape: {
      type:      'Optional[String]',
      desc:      'symbols to escape, use --escape, at this --count is invalid',
    },
  },
)
