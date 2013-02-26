# Symfony2 Vagrant configuration

Provides a basic installation to get up and running with a Symfony2
application quickly.

## What's in the box?

Firing up this VM will install the following packages:

* cURL
* MySQL (username: `root` and no password)
* nginx
* PHP-CLI
* PHP-FPM
* APC
* PEAR
* XDebug

Additionaly, it will create a MySQL database called `symfony` if it doesn't
exist so a clean Symfony2 installation should run right away (after you
installed the dependencies, of course).

## Installation

To use this configuration, you have to have [Vagrant](http://vagrantup.com)
installed!

Using this configuration is rather easy, just clone it inside the root of your
Symfony2 project:

```
$ git clone git@github.com:kleiram/vagrant-symfony.git vagrant
```

Or if you're using Git for your project (which you should!) you can add it as a
submodule (everyone cloning the project will get it in that case):

```
$ git submodule add git@github.com:kleiram/vagrant-symfony.git vagrant
```

After the repository is cloned, go into the folder in which you cloned the
repository and run:

```
$ vagrant up
```

It might take a while depending on your internet connection (it will download
a lot of stuff!) and it will ask for your password (because Vagrant is using NFS
to speed things up with caching).

After it is done setting up point your browser to[http://33.33.33.10](http://33.33.33.10)
and bask in the glory of Symfony!

### Note

If you're using Windows, you'll have to replace the following line in
the `Vagrantfile` because Windows doesn't support NFS:

```
config.vm.share_folder "v-root", "/vagrant", "..", :nfs => true
```

with:

```
config.vm.share_folder "v-root", "/vagrant", ".."

```

### Note

If you visit your site for the first time on `33.33.33.10` and you get the
following message it is an easy fix:

    You are not allowed to access this file. Check app_dev.php for more information.

You'll have to edit the `web/app_dev.php` file and remove the following piece
of code:

```php
if (isset($_SERVER['HTTP_CLIENT_IP'])
    || isset($_SERVER['HTTP_X_FORWARDED_FOR'])
    || !in_array(@$_SERVER['REMOTE_ADDR'], array('127.0.0.1', 'fe80::1', '::1'))
) {
    header('HTTP/1.0 403 Forbidden');
    exit('You are not allowed to access this file. Check '.basename(__FILE__).' for more information.');
}
```

## Updating

You can always run a `git pull` in the `vagrant` folder in your project root to
update the configuration.

## Versioning

This project is versioned using [Semantic Versioning](http://semver.org/spec/v1.0.0.html)
which means:

    The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
    "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to
    be interpreted as described in RFC 2119.

    Software using Semantic Versioning MUST declare a public API. This API could
    be declared in the code itself or exist strictly in documentation. However
    it is done, it should be precise and comprehensive.

    A normal version number MUST take the form X.Y.Z where X, Y, and Z are
    integers. X is the major version, Y is the minor version, and Z is the patch
    version. Each element MUST increase numerically by increments of one. For
    instance: 1.9.0 -> 1.10.0 -> 1.11.0.

    When a major version number is incremented, the minor version and patch
    version MUST be reset to zero. When a minor version number is incremented,
    the patch version MUST be reset to zero. For instance: 1.1.3 -> 2.0.0 and
    2.1.7 -> 2.2.0.

    A pre-release version number MAY be denoted by appending an arbitrary string
    immediately following the patch version and a dash. The string MUST be
    comprised of only alphanumerics plus dash [0-9A-Za-z-]. Pre-release versions
    satisfy but have a lower precedence than the associated normal version.
    Precedence SHOULD be determined by lexicographic ASCII sort order. For
    instance: 1.0.0-alpha1 < 1.0.0-beta1 < 1.0.0-beta2 < 1.0.0-rc1 < 1.0.0.

    Once a versioned package has been released, the contents of that version
    MUST NOT be modified. Any modifications must be released as a new version.

    Major version zero (0.y.z) is for initial development. Anything may change
    at any time. The public API should not be considered stable.

    Version 1.0.0 defines the public API. The way in which the version number
    is incremented after this release is dependent on this public API and how
    it changes.

    Patch version Z (x.y.Z | x > 0) MUST be incremented if only backwards
    compatible bug fixes are introduced. A bug fix is defined as an internal
    change that fixes incorrect behavior.

    Minor version Y (x.Y.z | x > 0) MUST be incremented if new, backwards
    compatible functionality is introduced to the public API. It MAY be
    incremented if substantial new functionality or improvements are introduced
    within the private code. It MAY include patch level changes. Patch version
    MUST be reset to 0 when minor version is incremented.

    Major version X (X.y.z | X > 0) MUST be incremented if any backwards
    incompatible changes are introduced to the public API. It MAY include minor
    and patch level changes. Patch and minor version MUST be reset to 0 when
    major version is incremented.


## License

This configuration is released under the BSD 2-clause license:

    Copyright (c) 2013, Ramon Kleiss <ramon@cubilon.nl>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
       list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    The views and conclusions contained in the software and documentation are those
    of the authors and should not be interpreted as representing official policies,
    either expressed or implied, of the FreeBSD Project.
