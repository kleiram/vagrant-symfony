class php5 {
    package { "php5-cli":
        ensure => installed,
    }

    package { "php5-fpm":
        ensure => installed,
    }

    service { "php5-fpm":
        ensure => running,
        require => Package["php5-fpm"],
    }

    package { [
        "php-apc",
        "php-pear",
        "php5-intl",
        "php5-mysql",
        "php5-xdebug",
    ]:
        ensure => installed,
        require => [Package["php5-cli"], Package["php5-fpm"]],
        notify => Service["php5-fpm"],
    }

    exec { "update-fpm-user":
        command => "sudo sed -i 's/user = www-data/user = vagrant/' /etc/php5/fpm/pool.d/www.conf",
        require => Package["php5-fpm"],
        notify => Service["php5-fpm"],
    }

    file { "/etc/php5/conf.d/xdebug.ini":
        ensure => file,
        source => "puppet:///modules/php5/xdebug.ini",
        require => [Package["php5-fpm"], Package["php5-cli"]],
        notify => Service["php5-fpm"],
    }
}
