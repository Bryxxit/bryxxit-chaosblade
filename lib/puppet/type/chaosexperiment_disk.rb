# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_disk',
  docs: <<-EOS,
@summary a chaosexperiment_disk type
@example
chaosexperiment_disk { 'foo':
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
      type:    'Enum[disk_burn, disk_fill]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'disk_burn',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    ### Disk fill/burn params
    size: {
      type:      'Optional[Integer]',
      desc:      'Block size in MB the default, for burn default is 10 for fill this is empty. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size ',
    },
    path: {
      type:      'Optional[String]',
      desc:      'The path of directory where the disk is burning/filling, default value is /. Or name of the file in file experiments.',
    },
    burn_method: {
      type:    'Optional[Enum[read, write, read_write]]',
      desc:    'Burn io by reading a file, writing a file or doing both. Burn io by read, it will create a 600M for reading and delete it when destroy it,  Burn io by write, it will create a file by value of the size flag, for example the size default value is 10, then it will create a 10M*100=1000M file for writing, and delete it when destroy',
      default: 'read',
    },
    percent: {
      type:      'Optional[Integer]',
      desc:      'Percent of disk to occupy in a disk fill experiment. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size',
    },
    reserve: {
      type:      'Optional[Integer]',
      desc:      'Number of mb reserve for the disk when doing a disk fill experiment. If size, percent and reserve flags exist, the priority is as follows: percent > reserve > size',
    },
    retain_file: {
      type:      'Optional[Boolean]',
      desc:      'Wheter to keep the large file created by fill or not.',
    },
  },
)
