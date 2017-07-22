FROM debian:testing
MAINTAINER Dr Suman Khanal <suman81765@gmail.com>
LABEL updated_at '2017-07-22'
RUN apt-get update \
  && apt-get install -y gnupg wget curl libgetopt-long-descriptive-perl libdigest-perl-md5-perl python3 python3-pygments
WORKDIR /usr/local/src
RUN curl -sL http://mirror.utexas.edu/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - && mv install-tl-20* install-tl

WORKDIR install-tl
RUN echo "selected_scheme scheme-full" > profile && ./install-tl -profile profile
WORKDIR /
ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH
CMD ["tlmgr", "--version"]
