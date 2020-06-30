#!/bin/sh

domain=
env=
password=
path=
s3folder=
site=
ticket=
type=

user=$site
dir=$HOME/$site
mkdir --parents $dir
wget https://$domain/$path/$site/ --user $user --password $password --recursive --no-parent --directory-prefix $dir
md5sum $dir/$domain/$path/$site/*
aws s3 cp $dir/$domain/$path/$site/ s3://$s3folder/$type-$env-$site-$ticket/ --recursive --exclude "index.html" --exclude "robots.txt";
for file in $dir/$domain/$path/$site/*;
do
        shred --remove $file;
done
rmdir --parents $dir/$domain/$path/$site/
