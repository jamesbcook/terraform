class cobaltstrike (String $cs_key) {

  if $cs_key == '' {
    fail('Missing cs_key')
  }

  cobaltstrike::download($cs_key, '/tmp/cobaltstrike.tgz')

  exec { 'unzip tar':
    command => 'tar zxf /tmp/cobaltstrike.tgz -C /opt',
    creates => '/opt/cobaltstrike',
    path    => '/bin/',
    onlyif  => '/usr/bin/test -f /tmp/cobaltstrike.tgz',
  }

  exec { 'cobaltstrike install':
    command => "printf \"${cs_key}\r\" | java -XX:ParallelGCThreads=4 -XX:+AggressiveHeap -XX:+UseParallelGC -jar /opt/cobaltstrike/update.jar",
    path    => '/usr/bin/',
    onlyif  => '/usr/bin/test -f /opt/cobaltstrike/update.jar',
  }

  exec { 'update':
    command => '/opt/cobaltstrike/update',
    cwd     => '/opt/cobaltstrike',
    onlyif  => '/usr/bin/test -f /opt/cobaltstrike/update',
  }

}
