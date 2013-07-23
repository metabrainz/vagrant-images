# Building Your Own Virtual Machine

## Prerequisites

* Git
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://vagrantup.com/)

This brief tutorial assumes that you have nothing listening on ports 2222 or
5000 before starting.

## Building a Virtual Machine

1. Clone this repository:

        git clone --recursive git://github.com/metabrainz/vagrant-images.git

2. Change to the cloned `musicbrainz-server` directory:

        cd vagrant-images/musicbrainz-server

3. Bring up the virtual machine:

        vagrant up

4. Wait while Chef provisions the virtual machine correctly.

SSH is running on this virtual machine on port 2222. You can login as using
`vagrant ssh`, or alternatively using `ssh` with the username `vagrant`,
password `vagrant`. musicbrainz-server is checked out as the `musicbrainz` user
in the `/home/musicbrainz/musicbrainz-server` directory.

The database is served by PostgreSQL, listening on port 5432 in the virtual
machine. This is not currently forwarded outside the virtual machine.

Once step 4 completes, you should have a functioning
[musicbrainz-server](http://github.com/metabrainz/musicbrainz-server.git). The
server itself is listening on port 5000. However, before you can use it
you will need add some data:

## Importing Data

The virtual machine database will initially be devoid of data; it is up to you
to import data. To import data, you can use the `admin/import-db.sh` script,
which assumes the following binaries are on your `PATH`:

* wget
* md5sum

Once you have verified these dependencies are installed, run:

    bash ./admin/import-db.sh

This script will download the latest database dumps to the `data` directory. If
files already exist here, you will be prompted to delete them, which you are
sugggested to do unless you know what you are doing. The script will then remove
any existing musicbrainz database, and import the new data.
