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

php::fpm::pool { 'www':
    user => "vagrant",
    group => "vagrant",
}

# Install and configure PHP modules
php::module { ['apc', 'pear']:
    package_prefix  => 'php-',
    notify          => Class['php::fpm::service'],
}

php::module { ['intl', 'mysql']:
    notify          => Class['php::fpm::service'],
}

php::module { 'xdebug':
    source          => '/tmp/vagrant-puppet/manifests/files/etc/php5/conf.d/xdebug.ini',
    notify          => Class['php::fpm::service'],
}

exec { 'install-composer':
    command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin",
    creates => "/usr/local/bin/composer.phar",
    require => Class['php'],
}

# Install and configure MySQL
class { 'mysql::server': }

mysql::db { 'symfony':
    user        => 'symfony',
    password    => '',
    host        => '%',
    grant       => ['ALL']
}

# Install nginx
package { 'nginx':
    ensure => present,
}

service { 'nginx':
    ensure => running,
}

file { "/etc/nginx/sites-enabled/symfony.conf":
    path => "/etc/nginx/sites-enabled/symfony.conf",
    ensure => present,
    source => "/tmp/vagrant-puppet/manifests/files/etc/nginx/conf.d/symfony.conf",
    notify => Service["nginx"],
    require => Package["nginx"],
}

file { "/etc/nginx/sites-enabled/default":
    ensure => absent,
}

# Install small packages
class { 'git': }
class { 'curl': }
class { 'sqlite': }
