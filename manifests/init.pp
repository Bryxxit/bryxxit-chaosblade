# 
class chaosblade (

) {

  contain chaosblade::install
  contain chaosblade::config
  contain chaosblade::service

  Class['chaosblade::install']
  -> Class['chaosblade::config']
  -> Class['chaosblade::service']
}
