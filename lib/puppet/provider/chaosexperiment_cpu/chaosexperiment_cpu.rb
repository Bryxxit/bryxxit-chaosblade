# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'
# Implementation for the chaosexperiment_cpu type using the Resource API.
class Puppet::Provider::ChaosexperimentCpu::ChaosexperimentCpu < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'cpu')
  end

  def experiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create cpu load "
    if should[:load]
      # percent shoudl be betweeen 0/100
      command += " --cpu-percent " + should[:load].to_s
    end
    if should[:climb]
      command += " --climb-time " + should[:climb].to_s
    end
    if should[:cpu_count]
      command += " --cpu-count " + should[:cpu_count].to_s
    end
    if should[:cpu_list]
      command += " --cpu-list " + should[:cpu_list]
    end
    s.launchExperiment(context, should, name, command)
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
