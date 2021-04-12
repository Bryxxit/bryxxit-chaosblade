# 
class chaosblade::config (

) {


  file { '/usr/lib/systemd/system/chaosblade.service':
    ensure  => file,
    content => epp('chaosblade/chaosblade.service.epp'),
  }

}
