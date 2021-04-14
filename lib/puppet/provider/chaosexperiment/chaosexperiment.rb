# frozen_string_literal: true
require 'json'
require 'puppet/resource_api/simple_provider'

# Implementation for the chaosexperiment type using the Resource API.
class Puppet::Provider::Chaosexperiment::Chaosexperiment < Puppet::ResourceApi::SimpleProvider
  def get(context)
    value = `blade status --type create`
    res = JSON.parse(value) 
    arr1 = res['result']
    arr2 = []
    arr1.each do |e|
      arr2.append(flagsToHash(e))
    end
    
    puts arr2
    arr2
  end


  def getAttackType(value)
    type = ''
    if value['Command'] == 'cpu'
      type = 'cpu'
    end

    type
  end
  def flagsToHash(value)
    en = 'present'
    if value['Status'] == 'Destroyed' || value['Status'] == 'Error'
     en = 'absent'
    end
    r = {
      name: value['Uid'],
      ensure: en,
      type: getAttackType(value)
    }
    flags = value['Flag'].split(" ")
    flags.each do |k|
      if k.start_with?("--uid=")
        k.sub! '--uid=', ''
        r[:name] = k
      end
      if k.start_with?("--cpu-percent=")
        k.sub! '--cpu-percent=', ''
        r[:load] = k.to_i
      end
      if k.start_with?("--climb-time=")
        k.sub! '--climb-time=', ''
        r[:climb] = k.to_i
      end
      if k.start_with?("--climb-time=")
        k.sub! '--climb-time=', ''
        r[:climb] = k.to_i
      end
      if k.start_with?("--cpu-count=")
        k.sub! '--cpu-count=', ''
        r[:cpu_count] = k.to_i
      end
      if k.start_with?("--cpu-list=")
        k.sub! '--cpu-list=', ''
        r[:cpu_list] = k
      end
      if k.start_with?("--timeout=")
        k.sub! '--timeout=', ''
        r[:timeout] = k.to_i
      end

  
    end
    r
  end


  def parseAttack(context, name, should)
    if should[:type] == 'cpu'
      cpuAttack(context, name, should)
    end

  end

  def cpuAttack(context, name, should)
    # TODO add some validation
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
    command = sharedSections(context, name, should, command)
    launchAttack(context, name, command)
  end

  def launchAttack(context, name, command)
    context.notice("creating chaos experiment #{name} '#{command}'")
    value = `#{command}`
  end


  def sharedSections(context, name, should, command)
    command += " --uid '#{name}'"
    if should[:timeout]
      command += " --timeout " + should[:timeout].to_s
    end
    command
  end

  def create(context, name, should)
    # TODO check stuff
    # if should[:ensure] == 'absent'
    # end
    # delete(context, name)

    parseAttack(context, name, should)
  end

  def update(context, name, should)
    delete(context, name)
    create(context, name, should)

  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    command = "blade destroy #{name} --force-remove"
    value = `#{command}`

  end
end
