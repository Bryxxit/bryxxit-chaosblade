# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'
# Implementation for the chaosexperiment_mem type using the Resource API.
class Puppet::Provider::ChaosexperimentMem::ChaosexperimentMem < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'mem')
  end

  def experiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create mem load "
    if should[:load]
      # percent shoudl be betweeen 0/100
      command += " --mem-percent " + should[:load].to_s
    end
    if should[:burn_method]
      command += " --mode=" + should[:burn_method]
    end
    if should[:rate]
      command += " --rate " + should[:rate].to_s
    end
    if should[:reserve]
      command += " --reserve " + should[:reserve].to_s
    end
    if should[:buffer]
      command += " --include-buffer-cache "
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
