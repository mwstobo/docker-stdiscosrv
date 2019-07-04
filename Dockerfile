FROM alpine:3.6

ARG version=v1.0.1
ARG buildhost=https://github.com/syncthing/discosrv/releases/download/${version}
ARG tar_filename=stdiscosrv-linux-amd64-${version}.tar.gz

ENV STDISCOSRV_ROOT=/opt/stdiscosrv
ENV STDISCOSRV_BIN=$STDISCOSRV_ROOT/bin
ENV PATH=$PATH:$STDISCOSRV_BIN

VOLUME ["/opt/stdiscosrv/data"]

RUN apk update \
 && apk add --no-cache \
            --virtual build \
            ca-certificates \
            wget \
 && update-ca-certificates \
 && wget ${buildhost}/${tar_filename} \
 && mkdir -p $STDISCOSRV_ROOT $STDISCOSRV_BIN \
 && tar xvf "${tar_filename}" -C $STDISCOSRV_BIN --strip 1 \
 && rm "${tar_filename}" \
 && apk del build

WORKDIR $STDISCOSRV_ROOT
CMD ["stdiscosrv", \
       "-db-dir=/opt/stdiscosrv/data/discovery.db", \
       "-cert=/opt/stdiscosrv/data/cert.pem", \
       "-key=/opt/stdiscosrv/data/key.pem"]

EXPOSE 8443
