# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'

# Implementation for the chaosexperiment_process type using the Resource API.
class Puppet::Provider::ChaosexperimentProcess::ChaosexperimentProcess < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'process')
  end

  def processhared(contect, name, should, command)
    if should[:process]
      command += " --process " + should[:process]
    end
    if should[:process_cmd]
      command += " --process-cmd " + should[:process_cmd]
    end
    if should[:timeout]
      command += " --timeout " + should[:timeout].to_s
    end
    if should[:ignore_not_found]
      command += " --ignore-not-found "
    end
    command
  end


  def processKillExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create process kill "
    command = processhared(context, name, should, command)
    if should[:count]
      command += " --count " + should[:count].to_s
    end
    if should[:local_port]
      command += " --local-port " + should[:local_port].to_s
    end
    if should[:signal]
      command += " --signal " + should[:signal].to_s
    end
    s.launchExperiment(context, should, name, command)
  end

  def processStopExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create process stop "
    command = processhared(context, name, should, command)
    s.launchExperiment(context, should, name, command)
  end

 


  def experiment(context, name, should)
    if should[:type] == 'process_kill'
      processKillExperiment(context, name, should)
    end
    if should[:type] == 'process_stop'
      processStopExperiment(context, name, should)
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
