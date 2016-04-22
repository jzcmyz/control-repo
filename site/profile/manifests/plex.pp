class profile::plex {

  firewall { '200 open Plex Media Server ports 32400 32469':
    proto => 'tcp',
    action => accept,
    dport => [ 32400, 32469 ],
  }

  firewall { '201 open Plex Media Server port for DLNA':
    proto => 'udp',
    action => accept,
    dport => [ 1900, 5353 ],
  }

  class {'plexmediaserver':
    plex_user                                 => 'plex',
    plex_media_server_home                    => '/usr/lib/plexmediaserver',
    plex_media_server_max_plugin_procs        => '7',
    plex_media_server_max_stack_size          => '20000',
    plex_media_server_max_lock_mem            => '4000',
    plex_media_server_max_open_files          => '1024',
    plex_media_server_tmpdir                  => '/tmp',
    plex_url => 'https://downloads.plex.tv/plex-media-server/0.9.16.4.1911-ee6e505',
    plex_pkg => "plexmediaserver-0.9.16.4.1911-ee6e505.${::architecture}.rpm",
  }

#
# Need to create mountpoint before mounting NFS share
#
  mounttab {'/mnt/media':
    ensure => present,
    fstype => 'nfs',
    device => 'freenas.ring.net:/mnt/datastore/media',
    options => 'defaults',
    provider => augeas,
  }

}

