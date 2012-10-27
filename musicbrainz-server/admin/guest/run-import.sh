#!bash
if (psql -U postgres -Atc "SELECT datname FROM pg_database" | grep -q musicbrainz)
then
    dropdb -U postgres musicbrainz
fi

perl /home/musicbrainz/musicbrainz-server/admin/InitDb.pl --createdb \
  --import /vagrant/data/mbdump*.tar.bz2
