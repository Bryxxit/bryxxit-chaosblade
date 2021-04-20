# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'
# Implementation for the chaosexperiment_disk type using the Resource API.
class Puppet::Provider::ChaosexperimentDisk::ChaosexperimentDisk < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'disk')
  end

  def diskShared(contect, name, should, command)
    if should[:size]
      # percent shoudl be betweeen 0/100
      command += " --size " + should[:size].to_s
    end
    if should[:path]
      # percent shoudl be betweeen 0/100
      command += " --path " + should[:path]
    end
    command
  end

  def diskFillExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create disk fill "
    command = diskShared(context, name, should, command)
    if should[:disk_usage]
      ## TODO max 100%
      command += " --percent " + should[:disk_usage].to_s
    end
    if should[:reserve]
      command += " --reserve " + should[:reserve].to_s
    end
    if should[:retain_file]
      command += " --retain-handle "
    end
    s.launchExperiment(context, should, name, command)
  end

  def diskBurnExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create disk burn "
    command = diskShared(context, name, should, command)
    if should[:burn_method]
      if should[:burn_method] == 'read'
        command += " --read "
      elsif should[:burn_method] == 'write'
        command += " --write "
      elsif should[:burn_method] == 'read_write'
        command += " --read --write"
      else
        command += " --read "
      end
    end
    s.launchExperiment(context, should, name, command)
  end

  def experiment(context, name, should)
    if should[:type] == 'disk_burn'
      diskBurnExperiment(context, name, should)
    end
    if should[:type] == 'disk_fill'
      diskFillExperiment(context, name, should)
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
