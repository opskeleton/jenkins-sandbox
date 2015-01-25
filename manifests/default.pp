group{ 'puppet': ensure  => present }

node 'jenkins.local' {
  include jenkins
  include jdk
  include build::gradle
  jenkins::plugin {'git' : version => '2.3.4' }
  jenkins::plugin {'gradle' : version => '1.24' }

  package{['git']:
    ensure  => present
  }

}
