FROM ubuntu:bionic as build
WORKDIR /build

COPY build_packages.sh /build/

RUN /build/build_packages.sh


FROM ubuntu:bionic as publish

COPY --from=build /build/fr24feed /usr/local/bin/
COPY init /init
COPY build_publish.sh /tmp/

RUN /tmp/build_publish.sh && rm -f /tmp/build_publish.sh

EXPOSE 8754

USER fr24feed
CMD ["/init"]
