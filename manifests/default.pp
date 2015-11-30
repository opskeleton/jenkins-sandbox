node default {

  include jenkinssecurity::nginx

  class{'jenkins':
    install_java => false
  }

  class{'jdk':
    version => 8
  }

  include build::gradle

  jenkins::plugin {['git','credentials','git-client',
                      'scm-api', 'matrix-project','token-macro',
                      'ssh-credentials', 'mailer']: }
  
  jenkins::plugin {'gradle' : version => '1.24' }

  package{ 'git':
    ensure  => present
  }

  package{ ['python-software-properties', 'software-properties-common']:
    ensure  => present
  } -> Exec <||>
}
