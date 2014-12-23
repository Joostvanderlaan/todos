# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
##FROM phusion/passenger-full:<VERSION>
# Or, instead of the 'full' variant, use one of these:
#FROM phusion/passenger-ruby19:<VERSION>
#FROM phusion/passenger-ruby20:<VERSION>
#FROM phusion/passenger-ruby21:<VERSION>
FROM phusion/passenger-nodejs:0.9.14
#FROM phusion/passenger-customizable:<VERSION>
MAINTAINER Joost van der Laan

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# install meteor (Only required when NOT using a meteor bundle / build)
# RUN curl https://install.meteor.com | /bin/sh

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
#RUN /build/utilities.sh
#   Ruby support.
#RUN /build/ruby1.9.sh
#RUN /build/ruby2.0.sh
#RUN /build/ruby2.1.sh
#   Python support.
#RUN /build/python.sh
#   Node.js and Meteor support.
RUN /build/nodejs.sh

# See readme file in your Meteor bundle what dependencies you should add here
RUN npm install fibers@1.0.1
RUN npm install underscore
RUN npm install source-map-support
RUN npm install semver

# ...put your own build instructions here...

# Deploy the Nginx configuration file for webapp
ADD docker/webapp.conf /etc/nginx/sites-enabled/webapp.conf

RUN mkdir /home/app/webapp
#RUN ...commands to place your web app in /home/app/webapp...
#ADD . /home/app/webapp
ADD ./deploy /home/app/webapp
# enable NGINX
RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*