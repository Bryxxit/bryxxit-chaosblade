# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'

# Implementation for the chaosexperiment_network type using the Resource API.
class Puppet::Provider::ChaosexperimentNetwork::ChaosexperimentNetwork < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'network')
  end


  def networkShared(contect, name, should, command)
    if should[:destination_ip]
      command += " --destination-ip=\"" + should[:destination_ip] + "\""
    end
    if should[:exclude_ip]
      command += " --exclude-ip=\"" + should[:exclude_ip] + "\""
    end
    if should[:exclude_port]
      command += " --exclude-port=\"" + should[:exclude_port] + "\""
    end

    if should[:force]
      command += " --force "
    end
    if should[:ignore_peer_port]
      command += " --ignore-peer-port "
    end

    if should[:interface]
      command += " --interface=\"" + should[:interface] + "\""
    end
    if should[:local_port]
      command += " --local-port=\"" + should[:local_port] + "\""
    end
    if should[:remote_port]
      command += " --remote-port=\"" + should[:remote_port] + "\""
    end
    
    command
  end

  def networkCorruptExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network corrupt "
    command = networkShared(context, name, should, command)
    if should[:percent]
      command += " --percent=" + should[:percent].to_s
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkDelayExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network delay "
    command = networkShared(context, name, should, command)
    if should[:offset]
      command += " --offset=" + should[:offset].to_s
    end
    if should[:time]
      command += " --time=" + should[:time].to_s
    end
    s.launchExperiment(context, should, name, command)
  end

  def networkDNSExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network dns "
    if should[:ip]
      command += " --ip=\"" + should[:ip] + "\""
    end
    if should[:domain]
      command += " --domain=\"" + should[:domain] + "\""
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkDropExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network drop "
    if should[:destination_ip]
      command += " --destination-ip=\"" + should[:destination_ip] + "\""
    end
    if should[:destination_port]
      command += " --destination-port=\"" + should[:destination_port] + "\""
    end
    if should[:network_traffic]
      command += " --netwokr-traffic=\"" + should[:network_traffic] + "\""
    end
    if should[:source_ip]
      command += " --source-ip=\"" + should[:source_ip] + "\""
    end
    if should[:source_port]
      command += " --source-port=\"" + should[:source_port] + "\""
    end
    if should[:string_pattern]
      command += " --string-pattern=\"" + should[:string_pattern] + "\""
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkDuplicateExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network duplicate "
    command = networkShared(context, name, should, command)
    if should[:percent]
      command += " --percent=" + should[:percent].to_s
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkLossExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network loss "
    command = networkShared(context, name, should, command)
    if should[:percent]
      command += " --percent=" + should[:percent].to_s
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkOccupyExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network occupy "
    if should[:port]
      command += " --port=" + should[:port].to_s
    end
    if should[:force]
      command += " --force "
    end

    s.launchExperiment(context, should, name, command)
  end

  def networkReorderExperiment(context, name, should)
    s = Chaosexperiment.new
    command = "blade create network reorder "
    command = networkShared(context, name, should, command)
    if should[:correlation]
      command += " --correlation=" + should[:correlation].to_s
    end
    if should[:gap]
      command += " --gap=" + should[:gap].to_s
    end
    if should[:time]
      command += " --time=" + should[:time].to_s
    end
    if should[:percent]
      command += " --percent=" + should[:percent].to_s
    end
    

    s.launchExperiment(context, should, name, command)
  end


  def experiment(context, name, should)
    if should[:type] == 'network_corrupt'
      networkCorruptExperiment(context, name, should)
    end
    if should[:type] == 'network_delay'
      networkDelayExperiment(context, name, should)
    end
    if should[:type] == 'network_dns'
      networkDNSExperiment(context, name, should)
    end
    if should[:type] == 'network_drop'
      networkDropExperiment(context, name, should)
    end
    if should[:type] == 'network_duplicate'
      networkDuplicateExperiment(context, name, should)
    end
    if should[:type] == 'network_loss'
      networkLossExperiment(context, name, should)
    end
    if should[:type] == 'network_occupy'
      networkOccupyExperiment(context, name, should)
    end
    if should[:type] == 'network_reorder'
      networkReorderExperiment(context, name, should)
    end
  end

  
  def create(context, name, should)
    delete(context, name)
    experiment(context, name, should)
  end

  def update(context, name, should)
    create(context, name, should)
  end

  def delete(context, name)
    command = "blade destroy #{name} --force-remove"
    value = `#{command}`
  end
end
