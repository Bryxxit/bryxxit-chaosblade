# chaosblade
#
# Main class, includes all other classes. Just unwraps the package so the resources can use it.
#
# @param version
#   Chaosblade version. Default is 1.0.0
#
# @param broadcastclient
#   The dir to extract the tar to default is /opt
#
# @param url
#   The url location of the tar file default is from the github repo
#
class chaosblade (
  String $version = '1.0.0',
  String $extract_dir = '/opt',
  String $url = "https://github.com/chaosblade-io/chaosblade/releases/download/v${chaosblade::version}/chaosblade-${chaosblade::version}-linux-amd64.tar.gz"

) {

  contain chaosblade::install
  contain chaosblade::config
  contain chaosblade::service

  Class['chaosblade::install']
  -> Class['chaosblade::config']
  -> Class['chaosblade::service']
}
