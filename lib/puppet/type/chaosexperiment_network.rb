# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'chaosexperiment_network',
  docs: <<-EOS,
@summary a chaosexperiment_network type
@example
chaosexperiment_network { 'foo':
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
      type:    'Enum[network_corrupt, network_delay, network_dns, network_drop, network_duplicate, network_loss, network_occupy, network_reorder]',
      desc:    'The type of experiment you would like to trigger.',
      default: 'process_corrupt',
    },
    timeout: {
      type:      'Optional[Integer]',
      desc:      'The duration of the experiment',
    },
    destination_ip: {
      type:      'Optional[String]',
      desc:      'destination ip. Support for using mask to specify the ip range such as 92.168.1.0/24 or comma separated multiple ips, for example 10.0.0.1,11.0.0.1.',
    },
    exclude_ip: {
      type:      'Optional[String]',
      desc:      'Exclude ips. Support for using mask to specify the ip range such as 92.168.1.0/24 or comma separated multiple ips, for example 10.0.0.1,11.0.0.1',
    },
    exclude_port: {
      type:      'Optional[String]',
      desc:      'Exclude local ports. Support for configuring multiple ports, separated by commas or connector representing ranges, for example: 22,8000. This flag is invalid when --local-port or --remote-port is specified',
    },
    force: {
      type:      'Optional[Bolean]',
      desc:      'Forcibly overwrites the original rules',
    },
    ignore_peer_port: {
      type:      'Optional[Bolean]',
      desc:      'ignore excluding all ports communicating with this port, generally used when the ss command does not exist',
    },
    interface: {
      type:      'Optional[Bolean]',
      desc:      'Network interface, for example, eth0 (required)',
    },
    local_port: {
      type:      'Optional[String]',
      desc:      'Ports for local service. Support for configuring multiple ports, separated by commas or connector representing ranges, for example: 80,8000-8080',
    },
    percent: {
      type:      'Optional[Integer]',
      desc:      'Corruption/deuplication/loss percent, must be positive integer without %, for example, --percent 50 (required for corrupt)',
    },
    remote_port: {
      type:      'Optional[String]',
      desc:      'Ports for remote service. Support for configuring multiple ports, separated by commas or connector representing ranges, for example: 80,8000-8080',
    },
    delay: {
      type:      'Optional[Integer]',
      desc:      'Delay offset time, ms',
    },
    ip: {
      type:      'Optional[Integer]',
      desc:      'Domain ip (required for dns)',
    },
    domain: {
      type:      'Optional[Integer]',
      desc:      'Domain name (required for dns)',
    },
    network_traffic: {
      type:    'Optional[Enum[out, in]]',
      desc:    'The direction of network traffic eg. --network-traffic out',
      default: 'present',
    },
    destination_port: {
      type:      'Optional[String]',
      desc:      'The destination port of packet',
    },
    source_ip: {
      type:      'Optional[String]',
      desc:      'The source ip address of packet',
    },
    source_port: {
      type:      'Optional[Integer]',
      desc:      'The source port of packet',
    },
    port: {
      type:      'Optional[Integer]',
      desc:      'The port occupied (required for occupy)',
    },
    force: {
      type:      'Optional[Bolean]',
      desc:      'Force kill the process which is using the port',
    },
    time: {
      type:      'Optional[Integer]',
      desc:      'Delay time, must be positive integer, unit is millisecond, default value is 10',
    },
  },
)
