group{ 'puppet': ensure  => present }

node 'jenkins.local' {
  include jenkins
  include jdk
  include build::gradle

  jenkins::plugin {['git','credentials','git-client',
                      'scm-api', 'matrix-project','token-macro',
                      'ssh-credentials', 'mailer']: }

  jenkins::plugin {'gradle' : version => '1.24' }

  package{['git']:
    ensure  => present
  }

}
