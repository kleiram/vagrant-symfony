class mysql {
    package { "mysql-server":
        ensure => installed,
    }

    service { "mysql":
        ensure => running,
        require => Package["mysql-server"],
    }
}
