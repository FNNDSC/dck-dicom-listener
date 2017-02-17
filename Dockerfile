FROM ubuntu:latest
MAINTAINER fnndsc "dev@babymri.org"

RUN apt-get update \
  && apt-get install -y dcmtk \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && pip install pypx

EXPOSE 10401
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/etc/init.d/xinetd", "start"]
