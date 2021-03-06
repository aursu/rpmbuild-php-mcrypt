ARG centos=7.8.2003
ARG image=php-7.3

FROM aursu/pearbuild:${centos}-${image}

RUN yum -y install \
        libmcrypt-devel \
    && yum clean all && rm -rf /var/cache/yum /var/cache/dnf

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER

ENTRYPOINT ["/usr/bin/rpmbuild", "php-pecl-mcrypt.spec"]
CMD ["-ba"]
