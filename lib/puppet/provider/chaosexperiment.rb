class Chaosexperiment  
    def initialize()
    end
    def get(context)
        value = `blade status --type create`
        res = JSON.parse(value) 
        arr1 = res['result']
        arr2 = []
        arr1.each do |e|
          arr2.append(flagsToHash(e))
        end
        
        arr2
    end

    def getByType(context, expType)
        value = `blade status --type create`
        res = JSON.parse(value) 
        arr1 = res['result']
        arr2 = []
        arr1.each do |e|
          d = flagsToHash(e)
          if d[:type].start_with?(expType)
          arr2.append(d)
          end
        end
        # puts arr2
        arr2
    end



    def getAttackType(value)
        type = ''
        if value['Command'] == 'cpu'
          type = 'cpu'
        end
        if value['Command'] == 'mem'
          type = 'mem'
        end
        if value['Command'] == 'disk'
          if value['SubCommand'] == 'burn'
            type = 'disk_burn'
          end
          if value['SubCommand'] == 'fill'
            type = 'disk_fill'
          end
        end
        if value['Command'] == 'file'
          if value['SubCommand'] == 'add'
            type = 'file_add'
          end
          if value['SubCommand'] == 'append'
            type = 'file_append'
          end
          if value['SubCommand'] == 'chmod'
            type = 'file_chmod'
          end
          if value['SubCommand'] == 'delete'
            type = 'file_delete'
          end
          if value['SubCommand'] == 'move'
            type = 'file_move'
          end
        end
        if value['Command'] == 'process'
          if value['SubCommand'] == 'kill'
            type = 'process_kill'
          end
          if value['SubCommand'] == 'stop'
            type = 'process_stop'
          end
        end
        if value['Command'] == 'strace'
          if value['SubCommand'] == 'delay'
            type = 'strace_delay'
          end
          if value['SubCommand'] == 'error'
            type = 'strace_error'
          end
        end
        if value['Command'] == 'network'
          if value['SubCommand'] == 'corrupt'
            type = 'network_corrupt'
          end
          if value['SubCommand'] == 'delay'
            type = 'network_delay'
          end
          if value['SubCommand'] == 'dns'
            type = 'network_dns'
          end
          if value['SubCommand'] == 'drop'
            type = 'network_drop'
          end
          if value['SubCommand'] == 'duplicate'
            type = 'network_duplicate'
          end
          if value['SubCommand'] == 'loss'
            type = 'network_loss'
          end
          if value['SubCommand'] == 'occupy'
            type = 'network_occupy'
          end
          if value['SubCommand'] == 'reorder'
            type = 'network_reorder'
          end
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
          ## CPU stuff
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
          ### disk_burn stuff
          if k.start_with?("--size=")
            k.sub! '--size=', ''
            r[:size] = k.to_i
          end
          if k.start_with?("--percent=")
            k.sub! '--percent=', ''
            r[:usage] = k.to_i
          end
          if k.start_with?("--reserve=")
            k.sub! '--reserve=', ''
            r[:reserve] = k.to_i
          end
          if k.start_with?("--retain-handle")
            r[:retain_file] = true
          end
          if k.start_with?("--path=")
            k.sub! '--path=', ''
            r[:path] = k
            
          end
          if k.start_with?("--filepath=")
            k.sub! '--filepath=', ''
            r[:path] = k
          end
          if k.start_with?("--content=")
            k.sub! '--content=', ''
            r[:content] = k
          end
          if k.start_with?("--auto-create-dir")
            r[:create_dir] = true
          end
          if k.start_with?("--directory")
            r[:directory] = true
          end
          if k.start_with?("--enable-base64")
            r[:enable_base64] = true
          end
          if k.start_with?("--force")
            r[:force] = true
          end
          if k.start_with?("--read")
            k.sub! '--read', ''
            if r[:burn_method] == 'write'
              r[:burn_method] = 'read_write'
            else
              r[:burn_method] = 'read'
            end
          end
          if k.start_with?("--write")
            k.sub! '--write', ''
            if r[:burn_method] == 'read'
              r[:burn_method] = 'read_write'
            else
              r[:burn_method] = 'write'
            end
          end

          if k.start_with?("--count=")
            k.sub! '--count=', ''
            r[:count] = k.to_i
          end
          if k.start_with?("--interval=")
            k.sub! '--interval=', ''
            r[:interval] = k.to_i
          end
          if k.start_with?("--escape=")
            k.sub! '--escape=', ''
            r[:escape] = k
          end
          if k.start_with?("--mark=")
            k.sub! '--mark=', ''
            r[:mark] = k
          end
          if k.start_with?("--target=")
            k.sub! '--target=', ''
            r[:target] = k
          end
          if k.start_with?("--mem-percent=")
            k.sub! '--mem-percent=', ''
            r[:load] = k.to_i
          end
          if k.start_with?("--rate=")
            k.sub! '--rate=', ''
            r[:rate] = k.to_i
          end
          if k.start_with?("--mode=")
            k.sub! '--mode=', ''
            r[:burn_method] = k
          end
          if k.start_with?("--include-buffer-cache")
            r[:buffer] = true
          end
          if k.start_with?("--process=")
            k.sub! '--process=', ''
            r[:process] = k
          end
          if k.start_with?("--process-cmd=")
            k.sub! '--process-cmd=', ''
            r[:process_cmd] = k
          end
          if k.start_with?("--local-port=")
            k.sub! '--local-port=', ''
            r[:local_port] = k
          end
          if k.start_with?("--ignore-not-found")
            r[:ignore_not_found] = true
          end
          if k.start_with?("--signal=")
            k.sub! '--signal=', ''
            r[:signal] = k.to_i
          end
          
          if k.start_with?("--end=")
            k.sub! '--end=', ''
            r[:end] = k
          end
          if k.start_with?("--first=")
            k.sub! '--first=', ''
            r[:first] = k
          end
          if k.start_with?("--pid=")
            k.sub! '--pid=', ''
            r[:pid] = k.to_i
          end
          if k.start_with?("--step=")
            k.sub! '--step=', ''
            r[:step] = k
          end
          if k.start_with?("--syscall-name=")
            k.sub! '--syscall-name=', ''
            r[:syscall_name] = k
          end
          if k.start_with?("--return-value=")
            k.sub! '--return-value=', ''
            r[:return_value] = k
          end
          if k.start_with?("--delay-loc=")
            k.sub! '--delay-loc=', ''
            r[:delay_loc] = k
          end

          if k.start_with?("--destination-port=")
            k.sub! '--destination-port=', ''
            r[:destination_port] = k
          end
          if k.start_with?("--destination-ip=")
            k.sub! '--destination-ip=', ''
            r[:destination_ip] = k
          end
          if k.start_with?("--exclude-ip=")
            k.sub! '--exclude-ip=', ''
            r[:exclude_ip] = k
          end
          if k.start_with?("--exclude-port=")
            k.sub! '--exclude-port=', ''
            r[:exclude_port] = k
          end
          if k.start_with?("--ignore-peer-port")
            r[:ignore_peer_port] = true
          end
          if k.start_with?("--interface=")
            k.sub! '--interface=', ''
            r[:interface] = k
          end
          if k.start_with?("--remote-port=")
            k.sub! '--remote-port=', ''
            r[:remote_port] = k
          end
          if k.start_with?("--ip=")
            k.sub! '--ip=', ''
            r[:ip] = k
          end
          if k.start_with?("--domain=")
            k.sub! '--domain=', ''
            r[:domain] = k
          end
          if k.start_with?("-network-traffic=")
            k.sub! '-network-traffic=', ''
            r[:network_traffic] = k
          end
          if k.start_with?("--delay=")
            k.sub! '--delay=', ''
            r[:delay] = k.to_i
          end
          if k.start_with?("--source-port=")
            k.sub! '--source-port=', ''
            r[:source_port] = k
          end
          if k.start_with?("--source-ip=")
            k.sub! '--source-ip=', ''
            r[:source_ip] = k
          end
          if k.start_with?("--string-pattern=")
            k.sub! '--string-pattern=', ''
            r[:string_pattern] = k
          end
          if k.start_with?("--port=")
            k.sub! '--port=', ''
            r[:port] = k.to_i
          end
          if k.start_with?("--time=")
            if getAttackType(value) == 'strace_delay'
              k.sub! '--time=', ''
              r[:time] = k
            else
              k.sub! '--time=', ''
              r[:time] = k.to_i
            end
          end
          if k.start_with?("--correlation=")
            k.sub! '--correlation=', ''
            r[:correlation] = k.to_i
          end
          if k.start_with?("--gap=")
            k.sub! '--gap=', ''
            r[:gap] = k.to_i
          end
          if k.start_with?("--offset=")
            k.sub! '--offset=', ''
            r[:offset] = k.to_i
          end
        end
        r
      end

      def launchExperiment(context, should, name, command)
        context.notice("creating chaos experiment #{name} '#{command}'")
        command = sharedSections(context, name, should, command)
        value = `#{command}`
      end
    
    
      def sharedSections(context, name, should, command)
        command += " --uid '#{name}'"
        if should[:timeout]
          command += " --timeout " + should[:timeout].to_s
        end
        command
      end

end 