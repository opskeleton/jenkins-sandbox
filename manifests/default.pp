group{ 'puppet': ensure  => present }

node jenkins {
  include jenkins
  class{ jenkins:}
}
