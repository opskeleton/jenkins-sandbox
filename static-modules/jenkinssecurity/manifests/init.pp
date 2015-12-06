# Secured jenkins instance
class jenkinssecurity($user_hash = {}) {

  include jenkinssecurity::nginx
  include jenkinssecurity::jvm
  include jenkinssecurity::ssh

  class{'jenkins':
    install_java => false,
    user_hash    => $user_hash
  }

}
