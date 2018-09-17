
class letsencrypt(String $domain) {

  if $domain == '' {
    fail('Missing Domain Name')
  }

  exec { 'add-apt-certbot':
    command => '/usr/bin/add-apt-repository -y ppa:certbot/certbot'
  }

  exec { 'reload apt':
    command => '/usr/bin/apt-get update'
  }

  package { 'python-certbot-apache':
    ensure => 'installed'
  }

  exec { "install ${domain} certificate":
    command => "/usr/bin/certbot --apache -d ${domain} -n --register-unsafely-without-email --agree-tos"
  }

}
