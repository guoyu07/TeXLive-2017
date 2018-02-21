FROM debian:sid

LABEL maintainer="Dr Suman Khanal <suman81765@gmail.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
LABEL updated_at '2018-02-17'

RUN apt-get update \
  && apt-get install -y gnupg git wget curl make libgetopt-long-descriptive-perl \
  libdigest-perl-md5-perl python python-pygments && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/src
RUN curl -sL http://mirror.utexas.edu/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - \
  && mv install-tl-20* install-tl \
# After the above command runs, there will be a folder named install-tl in folder /usr/local/src
  && cd install-tl && echo "selected_scheme scheme-full" > profile \
  && ./install-tl -repository http://mirror.utexas.edu/ctan/systems/texlive/tlnet -profile profile \
  && cd .. \
  && rm -rf install-tl

WORKDIR /
ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH
RUN apt-get update && apt-get install -y libarchive-zip-perl \
  libfile-which-perl libimage-size-perl  \
  libio-string-perl libjson-xs-perl libtext-unidecode-perl \
  libparse-recdescent-perl liburi-perl libuuid-tiny-perl libwww-perl \
  libxml2 libxml-libxml-perl libxslt1.1 libxml-libxslt-perl  \
  imagemagick libimage-magick-perl && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/brucemiller/LaTeXML.git \
  && cd LaTeXML && perl Makefile.PL && make \
  && make install && cd .. && rm -rf LaTeXML 
CMD ["tlmgr", "--version"]
