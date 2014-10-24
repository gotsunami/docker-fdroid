docker-fdroid
=============

A Docker image for publishing your own Android application store using F-Droid.

The [F-Droid](https://f-droid.org/) server tools provide various scripts and tools 
that are used to maintain the main F-Droid application repository. You can use these 
same tools to create your own additional or alternative repository for publishing, 
or to assist in creating, testing and submitting metadata to the main repository.

This `gotsunami/fdroid` Docker image aims to ease the building of a "simple binary repository",
 as defined in [F-Droid's server manual](https://f-droid.org/manual/fdroid.html#Simple-Binary-Repository).

That means only publishing of *binary APKs* is supported at the moment. If all you want is 
easily making available a bunch of Android applications to users through an F-Droid repository, with
automatic app updates, this Docker image might do the trick.

**Warning**: no [repository index signing](https://f-droid.org/manual/fdroid.html#Signing) at 
the moment (*work in progress*).

### Quick Start

First, pull the Docker image:

    $ docker pull gotsunami/fdroid

Then create a directory where all your Android `.apk` files will belong to:

    $ export APK_REPO=~/apk
    $ mkdir $APK_REPO

Copy some APK files there then build the F-Droid repository (static data) with:

    $ docker run --rm -v $APK_REPO:/apk/repo gotsunami/fdroid

That's it! Your `APK_REPO` directory holds applications and metadata ready to be
served with your web server.

### Serving Files With nginx

If you need to install a web server for serving static content from this new repository,
just grab `nginx` and run it:

    $ docker pull nginx
    $ docker run -d --name nginx-fdroid \
        -v $APK_REPO:/usr/share/nginx/html:ro \
        -p 8080:80 nginx

### Customization

You might certainly want to customize the repo description and title, right? Just grab a
copyt of the `config.py` file:

    $ wget https://raw.githubusercontent.com/gotsunami/docker-fdroid/master/config.py

Make the appropriate changes then use it when refreshing your application repository:

    $ docker run --rm -v $APK_REPO:/apk/repo -v config.py:/apk/config.py gotsunami/fdroid
