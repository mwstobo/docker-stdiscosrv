FROM alpine:3.5

ARG buildhost=https://build.syncthing.net/job/stdiscosrv/lastSuccessfulBuild/artifact
ARG version=v0.14.23+14-gfb6d453
ARG tar_filename=stdiscosrv-linux-amd64-${version}.tar.gz

ENV STDISCOSRV_ROOT=/opt/stdiscosrv
ENV STDISCOSRV_BIN=$STDISCOSRV_ROOT/bin
ENV PATH=$PATH:$STDISCOSRV_BIN

VOLUME ["/opt/stdiscosrv/data"]

RUN apk update \
 && apk add ca-certificates \
            wget \
 && update-ca-certificates \
 && wget ${buildhost}/${tar_filename} \
 && mkdir -p $STDISCOSRV_ROOT $STDISCOSRV_BIN \
 && tar xvf "${tar_filename}" -C $STDISCOSRV_BIN --strip 1 \
 && rm "${tar_filename}"

WORKDIR $STDISCOSRV_ROOT
CMD ["stdiscosrv", \
       "-cert=/opt/stdiscosrv/data/cert.pem", \
       "-key=/opt/stdiscosrv/data/key.pem"]

EXPOSE 8443
