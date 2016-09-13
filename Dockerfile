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
RUN echo "installing packages..."
RUN apt-get update -y && apt-get install git python python-pip golang libleveldb1 libleveldb-dev -y
#RUN yum install -y leveldb leveldb-devel && yum clean all -y

RUN echo "installing python components via pip..."
RUN pip3 install tornado requests requests_futures plyvel pycrypto
RUN pip3 install git+https://github.com/jadeblaquiere/ecpy.git
RUN pip3 install git+https://github.com/jadeblaquiere/python-ctcoinlib.git

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
# COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# create a non-priv user
RUN useradd --create-home --user-group --uid 1001 ciphrtxt
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 7754
EXPOSE 7764

# TODO: Set the default CMD for the image
# CMD ["usage"]


#install ctcd
RUN echo "####### Building ctcd #######"
RUN echo "### go get glide"
RUN go get -u github.com/Masterminds/glide
RUN echo "### download ctcd"
RUN (cd src/github.com/ ; mkdir jadeblaquiere )
RUN go get github.com/jadeblaquiere/ctcd
RUN echo "### glide install ctcd"
RUN (cd src/github.com/jadeblaquiere/ctcd ; ~/workspace/bin/glide install )
RUN echo "### go install ctcd"
RUN (cd src/github.com/jadeblaquiere/ctcd ; go install . ./cmd/... )

# Down

RUN git clone https://github.com/jadeblaquiere/msgstore.git
