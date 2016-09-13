# ciphrtxt-test
FROM ubuntu:14.04

# TODO: Put the maintainer name in the image metadata
MAINTAINER Joseph deBlaquiere <jadeblaquiere@yahoo.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 0.1

# TODO: Set labels used in OpenShift to describe the builder image
#LABEL io.k8s.description="Platform for building xyz" \
#      io.k8s.display-name="builder x.y.z" \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."

# TODO: Install required packages here:
RUN echo "installing leveldb, leveldb-devel"
RUN sudo apt-get update
RUN sudo apt-get install libleveldb1 libleveldb-dev
#RUN yum install -y leveldb leveldb-devel && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
# COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
#USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 7754

# TODO: Set the default CMD for the image
# CMD ["usage"]

RUN git clone https://github.com/jadeblaquiere/msgstore.git
