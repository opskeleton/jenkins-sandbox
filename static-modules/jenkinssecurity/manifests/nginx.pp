# Setting up reverse proxy as mentioned under 
class jenkinssecurity::nginx(
  $certdir = '/etc/nginx/ssl',
  $key = "${::fqdn}.key",
  $crt = "${::fqdn}.crt"
) {
  
  file{$certdir:
    ensure => directory,
  }

  $key_gen = "openssl req -newkey rsa:2048 -nodes -keyout ${::fqdn}.key  -x509 -days 365 -out ${::fqdn}.crt -subj '/CN=${::fqdn}'"

  $chipers = 'ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP'

  exec {'create_self_signed_sslcert':
    command => $key_gen,
    cwd     => $certdir,
    creates => [ "${certdir}/${::fqdn}.key", "${certdir}/${::fqdn}.crt", ],
    path    => ['/usr/bin', '/usr/sbin']
  } ~> Service['nginx']


  package{'nginx':
    ensure  => present
  } ->

  file { '/etc/nginx/sites-enabled/jenkins.conf':
    ensure  => file,
    mode    => '0644',
    content => template('jenkinssecurity/jenkins.conf.erb'),
    owner   => root,
    group   => root,
  } ->

  service{'nginx':
    ensure    => running,
    provider  => systemd,
    enable    => true,
    hasstatus => true,
  }

  file{'/etc/nginx/sites-enabled/default':
    ensure => absent
  } ~> Service['nginx']

  include ufw

  ufw::allow { 'allow-ssh-from-all':
      port => 22,
  }

  ufw::allow { 'allow-80':
    from => 'any',
    port => 80,
    ip   => 'any'
  }

  ufw::allow { 'allow-https-from-all':
    from => 'any',
    port => 443,
    ip   => 'any'
  }
}
