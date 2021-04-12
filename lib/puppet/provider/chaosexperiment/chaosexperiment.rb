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

  def flagsToHash(value)
    r = {
      name: value['Uid'],
      ensure: 'present',
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
    end
    r
  end

  def create(context, name, should)
    if should[:ensure] == 'absent'
      delete(context, name)
    end
    command = "blade create cpu load --uid '#{name}' "
    if should[:load]
      command += "--cpu-percent " + should[:load].to_s
    end
    context.notice("creating chaos experiment #{name} '#{command}'")

    value = `#{command}`
  end

  def update(context, name, should)
    delete(context, name)
    create(context, name)

  end

  def delete(context, name)
    context.notice("Deleting '#{name}'")
    command = "blade destroy #{name} --force-remove"
    value = `#{command}`

  end
end
