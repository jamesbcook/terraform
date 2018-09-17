exec { '/usr/bin/apt-get update':
}

package { 'apt-transport-https':
  ensure => 'installed'
}

package { 'ca-certificates':
  ensure => 'installed'
}

package { 'curl':
  ensure => 'installed'
}

package { 'default-jre':
  ensure => 'installed'
}

package { 'software-properties-common':
  ensure => 'installed'
}

package { 'openssl':
  ensure => 'installed'
}

package { 'apache2':
  ensure => 'installed'
}

class { 'cobaltstrike':
  cs_key => '',
}

class { 'letsencrypt':
  domain => ''
}

class { 'cobaltstrike::keystore':
  domain   => '',
  password => ''
}
