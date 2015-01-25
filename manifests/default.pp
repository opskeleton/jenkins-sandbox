group{ 'puppet': ensure  => present }

node 'jenkins.local' {
  include jenkins
  jenkins::plugin {'git' : version => '1.1.26' }
  jenkins::plugin {'mercurial' : version => '1.42' }
  jenkins::plugin {'gradle' : version => '1.21' }

  package{['mercurial','git']:
    ensure  => present
  }
  include jdk
  include build::gradle
}
