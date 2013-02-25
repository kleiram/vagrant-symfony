class symfony {
    include nginx
    include mysql

    file { "/etc/nginx/sites-enabled/symfony.conf":
        path => "/etc/nginx/sites-enabled/symfony.conf",
        ensure => present,
        source => "puppet:///modules/symfony/symfony.conf",
        notify => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/sites-enabled/default":
        ensure => absent,
    }

    exec { "symfony-database":
        command => "mysql -u root -e 'CREATE DATABASE IF NOT EXISTS `symfony`;'",
        require => Service["mysql"],
    }

    exec { "symfony-access":
        command => "mysql -u root -e 'GRANT ALL PRIVILEGES ON *.* TO `root`@`10.0.2.2` WITH GRANT OPTION; FLUSH PRIVILEGES;'",
        require => Service["mysql"],
    }

    exec { "remote-access":
        command => 'sed "s/bind-address/#bind-address/" -i /etc/mysql/my.cnf',
        require => Package["mysql-server"],
        notify => Service["mysql"],
    }
}
