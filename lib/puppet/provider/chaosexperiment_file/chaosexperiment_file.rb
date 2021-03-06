# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require_relative '../chaosexperiment'

# Implementation for the chaosexperiment_file type using the Resource API.
class Puppet::Provider::ChaosexperimentFile::ChaosexperimentFile < Puppet::ResourceApi::SimpleProvider
  def get(context)
    s = Chaosexperiment.new
    s.getByType(context, 'file')
  end

  def fileShared(contect, name, should, command)
    if should[:path]
      # percent shoudl be betweeen 0/100
      command += " --filepath " + should[:path]
    end
    
    command
  end


  def fileAddExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create file add "
    command = fileShared(context, name, should, command)
    if should[:content]
      command += " --content=\"" + should[:content] + "\""
    end
    if should[:enable_base64]
      command += " --enable-base64 "
    end
    if should[:create_dir]
      command += " --auto-create-dir "
    end
    if should[:directory]
      command += " --directory "
    end
    s.launchExperiment(context, should, name, command)
  end

  def fileAppendExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create file append "
    command = fileShared(context, name, should, command)
    if should[:content]
      command += " --content=\"" + should[:content] + "\""
    end
    if should[:enable_base64]
      command += " --enable-base64 "
    end
    if should[:count]
      command += " --count " + should[:count].to_s
    end
    if should[:interval]
      command += " --interval " + should[:interval].to_s
    end
    if should[:escape]
      command += " --escape=\"" + should[:escape] + "\""
    end
    s.launchExperiment(context, should, name, command)
  end

  def fileChmodExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create file chmod "
    command = fileShared(context, name, should, command)
    if should[:mark]
      command += " --mark=\"" + should[:mark] + "\""
    end
    s.launchExperiment(context, should, name, command)
  end

  def fileDeleteExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create file delete "
    command = fileShared(context, name, should, command)
    if should[:force]
      command += " --force "
    end
    s.launchExperiment(context, should, name, command)
  end

  def fileMoveExperiment(context, name, should)
    s = Chaosexperiment.new

    command = "blade create file move "
    command = fileShared(context, name, should, command)
    if should[:create_dir]
      command += " --auto-create-dir "
    end
    if should[:force]
      command += " --force "
    end
    if should[:target]
      command += " --target=\"" + should[:target] + "\""
    end
    s.launchExperiment(context, should, name, command)
  end


  def experiment(context, name, should)
    if should[:type] == 'file_add'
      fileAddExperiment(context, name, should)
    end
    if should[:type] == 'file_append'
      fileAppendExperiment(context, name, should)
    end
    if should[:type] == 'file_chmod'
      fileChmodExperiment(context, name, should)
    end
    if should[:type] == 'file_delete'
      fileDeleteExperiment(context, name, should)
    end
    if should[:type] == 'file_move'
      fileMoveExperiment(context, name, should)
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
