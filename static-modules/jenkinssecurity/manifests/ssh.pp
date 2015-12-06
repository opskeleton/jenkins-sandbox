# Setting up ssh keys
class jenkinssecurity::ssh(
  $keys = {},
  $user = 'vagrant'
) {

  create_resources('ssh_authorized_key',  $keys, {user => $user})

}
