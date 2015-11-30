# Secured jenkins instance
class jenkinssecurity {

  include jenkinssecurity::nginx
  include jenkinssecurity::jvm

  class{'jenkins':
    install_java => false
  }

}
