#!/bin/bash

echo "SRE_TOOLING_SERVER_GROUP=\"${group}\"" >> /etc/default/sre-tooling
echo "SRE_TOOLING_REGION=\"${region}\"" >> /etc/default/sre-tooling

. /home/rapidpro/.virtualenvs/rapidpro/bin/activate
. /home/rapidpro/app/django.sh
cd /home/rapidpro/app
python manage.py migrate --noinput
python manage.py collectstatic --noinput
python manage.py compress --extension haml,html --force
chown -R rapidpro:www-data /home/rapidpro/app/sitestatic
unlink /etc/nginx/sites-enabled/default || echo "Already unlinked"
systemctl reload nginx.service
systemctl enable rapidpro.service
systemctl start rapidpro.service
systemctl enable celeryd-rapidpro.service
systemctl start celeryd-rapidpro.service
systemctl enable celerybeat-rapidpro.service
systemctl start celerybeat-rapidpro.service
