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
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the attack',
    },
    ### Cpu params
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
      desc:      'The number of cpus to use in the attack',
    },
    cpu_list: {
      type:      'Optional[String]',
      desc:      'CPUs in which to allow burning (0-3 or 1,3)',
    },
    ### Disk fill/burn metrics
    size: {
      type:      'Optional[Integer]',
      desc:      'Block size in MB the default, for burn default is 10 for fill this is empty. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size ',
    },
    path: {
      type:      'Optional[String]',
      desc:      'The path of directory where the disk is burning/filling, default value is /',
    },
    burn_method: {
      type:    'Enum[read, write, read_write]',
      desc:    'Burn io by reading a file, writing a file or doing both. Burn io by read, it will create a 600M for reading and delete it when destroy it,  Burn io by write, it will create a file by value of the size flag, for example the size default value is 10, then it will create a 10M*100=1000M file for writing, and delete it when destroy',
      default: 'read',
    },
    disk_usage: {
      type:      'Optional[Integer]',
      desc:      'Percent of disk to occupy in a disk fill experiment. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size',
    },
    disk_reserve: {
      type:      'Optional[Integer]',
      desc:      'Number of mb reserve for the disk when doing a disk fill experiment. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size',
    },
    retain_file: {
      type:      'Optional[Boolean]',
      desc:      'Wheter to keep the large file created by fill or not.',
    },
  },
)
