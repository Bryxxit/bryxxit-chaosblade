# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'

# Implementation for the chaosexperiment_strace type using the Resource API.
class Puppet::Provider::ChaosexperimentStrace::ChaosexperimentStrace < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'strace')
  end

  def straceShared(contect, name, should, command)
    if should[:end]
      command += " --end=\"" + should[:end] + "\""
    end
    if should[:first]
      command += " --first=\"" + should[:first] + "\""
    end
    if should[:pid]
      command += " --pid " + should[:pid].to_s

    end
    if should[:step]
      command += " --step=\"" + should[:step] + "\""
    end
    if should[:syscall_name]
      command += " --syscall-name=\"" + should[:syscall_name] + "\""
    end
    
    command
  end

  def straceDelayExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create strace delay "
    command = straceShared(context, name, should, command)
    if should[:time]
      command += " --time=\"" + should[:time] + "\""
    end
    if should[:delay_loc]
      command += " --delay-loc=\"" + should[:delay_loc] + "\""
    end
    
    s.launchExperiment(context, should, name, command)
  end

  def straceErrorExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create strace error "
    command = straceShared(context, name, should, command)
    if should[:return_value]
      command += " --return-value=\"" + should[:return_value] + "\""
    end
    s.launchExperiment(context, should, name, command)
  end


  def experiment(context, name, should)
    if should[:type] == 'strace_delay'
      straceDelayExperiment(context, name, should)
    end
    if should[:type] == 'strace_error'
      straceErrorExperiment(context, name, should)
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
