FROM python:3.7-alpine AS build

ARG S3QL_VERSION

RUN apk --no-cache add curl gnupg jq bzip2 g++ make pkgconfig fuse-dev sqlite-dev libffi-dev openssl-dev
RUN pip install --user --ignore-installed \
    cryptography defusedxml google-auth-oauthlib "apsw >= 3.7.0" "llfuse >= 1.0, < 2.0" "dugong >= 3.4, < 4.0"

ENV FILE="s3ql-$S3QL_VERSION"
ENV URL="https://github.com/s3ql/s3ql/releases/download/release-$S3QL_VERSION/$FILE.tar.bz2"

RUN set -x; \
    curl -sfL "$URL" -o "/tmp/$FILE.tar.bz2" \
 #&& curl -sfL "$URL.asc" | gpg2 --batch --verify - "/tmp/$FILE.tar.bz2" \
 && tar -xjf "/tmp/$FILE.tar.bz2"
WORKDIR $FILE
# RUN pip install --user --ignore-installed pycrypto # this is not needed v 3.3.2
RUN python3 setup.py build_ext --inplace \
 && python3 setup.py install --user

FROM python:3.7-alpine
RUN apk --no-cache add fuse psmisc
COPY --from=build /root/.local/bin/ /usr/local/bin/
COPY --from=build /root/.local/lib/ /usr/local/lib/
COPY ./entrypoint.sh  /usr/local/bin/
COPY ./authinfo2 /root/.s3ql/
RUN chmod 755 /usr/local/bin/*.sh
ENV MOUNTPOINT /cloud
ENV S3QL_ROOT /root/.s3ql
ENTRYPOINT ["/bin/sh","/usr/local/bin/entrypoint.sh"]
CMD ["/bin/sh"]
