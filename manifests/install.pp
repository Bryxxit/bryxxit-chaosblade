# 
class chaosblade::install (
) {


  archive { "/tmp/chaosblade-${chaosblade::version}-linux-amd64.tar.gz":
    ensure          => present,
    extract         => true,
    extract_path    => $chaosblade::extract_dir,
    source          => $chaosblade::url,
    checksum_verify => false,
    creates         => "${chaosblade::extract_dir}/chaosblade-${chaosblade::version}/blade",
    cleanup         => true,
  }

  -> file { '/usr/bin/blade':
    ensure => 'link',
    target => "${chaosblade::extract_dir}/chaosblade-${chaosblade::version}/blade",
  }
}
