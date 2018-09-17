class cobaltstrike::keystore(String $domain, String $password) {

  if $domain == '' {
    fail('Missing domain variable')
  }

  if $password == '' {
    fail('Missing password variable')
  }

  $letsencryptdir = "/etc/letsencrypt/live/${domain}"
  $fullchain      = "${letsencryptdir}/fullchain.pem"
  $privkey        = "${letsencryptdir}/privkey.pem"
  $pkcsfile       = "${letsencryptdir}/${domain}.pkcs"
  $dststore       = "${letsencryptdir}/${domain}.store"

  exec { 'check_fullchain':
    command => '/bin/true',
    onlyif  => "/usr/bin/test -e ${fullchain}",
  }

  exec { 'check_privkey':
    command => '/bin/true',
    onlyif  => "/usr/bin/test -e ${privkey}",
  }

  exec { 'Generating PKCS12 Keystore':
    command => "/usr/bin/openssl pkcs12 -export -in ${fullchain} -inkey ${privkey} -out ${pkcsfile} -name ${domain} -passout pass:${password}",
    onlyif  => '/usr/bin/test -f /usr/bin/openssl',
  }

  exec { 'check_dststore':
    command => '/bin/true',
    onlyif  => "/usr/bin/test -e ${dststore}",
  }

  exec { 'check_pkcsfile':
    command => '/bin/true',
    onlyif  => "/usr/bin/test -e ${pkcsfile}",
  }

  exec { 'Generating Java Keystore':
    command => "/usr/bin/keytool -importkeystore -deststorepass ${password} -destkeypass ${password} -destkeystore ${dststore} \
                -srckeystore ${pkcsfile} -srcstoretype PKCS12 -srcstorepass ${password} -alias ${domain}",
    onlyif  => '/usr/bin/test -f /usr/bin/keytool',
  }

  file { 'Copying Store to CS dir':
    ensure => present,
    source => $dststore,
    path   => "/opt/cobaltstrike/${domain}.store"
  }
}
