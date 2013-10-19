# Make sure apt-get update is run before installing any packages
Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
}

exec { "apt-update":
    command => "apt-get update"
}

Exec["apt-update"] -> Package <| |>

# Install and configure PHP
class { 'php': }
class { 'php::fpm': }

php::fpm::pool { 'master': }

# Install and configure PHP modules
php::module { ['apc', 'pear']:
    package_prefix  => 'php-',
    notify          => Class['php::fpm::service'],
}

php::module { ['intl', 'mysql']:
    notify          => Class['php::fpm::service'],
}

# Install and configure MySQL
class { 'mysql::server': }

mysql::db { 'symfony':
    user        => 'symfony',
    password    => '',
    host        => '%',
    grant       => ['ALL']
}
