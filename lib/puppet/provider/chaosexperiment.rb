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
        puts arr2
        arr2
    end



    def getAttackType(value)
        type = ''
        if value['Command'] == 'cpu'
          type = 'cpu'
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
            r[:disk_usage] = k.to_i
          end
          if k.start_with?("--reserve=")
            k.sub! '--reserve=', ''
            r[:disk_reserve] = k.to_i
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