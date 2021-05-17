# chaosblade
WIP: I'm working in a fork atm and will push regularly to main repo.

## Description

chaosblade is a module that will activate chaos engineering with puppet.
Chaos engineering can be used to test your environment for stability. Train engineers to solve, detect problems. In short applying chaos engineering to your environment will gain you valuable isights that can be used to improve your environment.

## Setup
The chaosblade executable needs to be active on the server for it to launch chaos experiments. This can be done with include chaosblade. Which will just download the exec from the github and create a symlink so it should be able to be used globally.

## Examples
```
 # Creates a load of 5% on a set of your cpu's
 chaosexperiment_cpu { 'cpuload1':
    ensure   => 'present',
    load     => 5,
    climb    => 60,
    timeout  => 60,
    cpu_list => '1,2'
  }

  # Create a file for reading an writing io. Block size is 15MB
  chaosexperiment_disk { 'diskburn1':
    type        => 'disk_burn',
    size        => 15,
    burn_method => 'read_write',
    timeout     => 60,
  }

  # Creates a file of 2048MB in /
  chaosexperiment_disk { 'diskfil1':
    type        => 'disk_fill',
    size        => 2048,
    retain_file => true,
    timeout     => 60,
  }

  # creates a file if not exists
  chaosexperiment_file { 'fileadd1':
    type       => 'file_add',
    path       => '/tmp/test/file.txt',
    content    => 'hello world',
    create_dir => true,
    timeout    => 120,
  }

  # Creates a directory if not exists
  chaosexperiment_file { 'fileadd2':
    type       => 'file_add',
    path       => '/tmp/test/dir',
    directory  => true,
    create_dir => true,
    timeout    => 120,
  }

  # adds the specified content to the file. It is repeated a number of times over certain intervals.
  chaosexperiment_file { 'fileappend1':
    type     => 'file_append',
    path     => '/file0.txt',
    content  => 'hello world',
    interval => 3,
    count    => 10,
    timeout  => 60,
  }

  # chmods a file with 777
  chaosexperiment_file { 'filechmod1':
    type    => 'file_chmod',
    mark    => '777',
    path    => '/file1.txt',
    timeout => 60,
  }

  # Deletes a file
  chaosexperiment_file { 'filedelete1':
    type    => 'file_delete',
    force   => true,
    path    => '/file2.txt',
    timeout => 60,
  }

  # move a file to a dir if not exists it creates it
  chaosexperiment_file { 'filemove1':
    type       => 'file_move',
    target     => '/file4.txt',
    create_dir => true,
    path       => '/file3.txt',
    timeout    => 60,
  }
  
  # creates memory load
  chaosexperiment_mem { 'memload1':
    ensure  => 'present',
    load    => 5,
    rate    => 2,
    timeout => 60,
  }
  # stops a specified process
  chaosexperiment_process { 'process1':
    ensure           => 'present',
    type             => 'process_stop',
    process_cmd      => 'sshd',
    ignore_not_found => true,
    timeout          => 60,
  }
  # kills a specified process on channel 9
  chaosexperiment_process { 'process2':
    ensure           => 'present',
    type             => 'process_kill',
    process_cmd      => 'ntp',
    ignore_not_found => true,
    signal           => 9,
    timeout          => 60,
  }
```  
