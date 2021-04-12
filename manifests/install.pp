# 
class chaosblade::install (

) {
  $version = '1.0.0'
  $url = "https://github.com/chaosblade-io/chaosblade/releases/download/v${version}/chaosblade-${version}-linux-amd64.tar.gz"
  archive { "/tmp/chaosblade-${version}-linux-amd64.tar.gz":
    ensure          => present,
    extract         => true,
    extract_path    => '/opt',
    source          => $url,
    checksum_verify => false,
    creates         => "/opt/chaosblade-${version}/blade",
    cleanup         => true,
  }

  -> file { '/usr/bin/blade':
    ensure => 'link',
    target => "/opt/chaosblade-${version}/blade",
  }
}
