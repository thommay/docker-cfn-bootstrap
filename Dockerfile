FROM progrium/busybox

RUN opkg-install bzip2 libsqlite3 libpthread zlib libopenssl wget ca-certificates \
 && mkdir /usr/local && wget -O /tmp/pyrun.tgz https://downloads.egenix.com/python/egenix-pyrun-2.0.1-py2.7_ucs4-linux-x86_64.tgz \
 && cd /tmp && gunzip pyrun.tgz && cd /usr/local && tar xf /tmp/pyrun.tar \
&& ln -s /usr/lib/libbz2.so.1.0 /usr/lib/libbz2.so.1 && ln -sf /lib/libpthread-2.18.so /lib/libpthread.so.0 \
&& wget -O /tmp/setuptools.tgz https://pypi.python.org/packages/source/s/setuptools/setuptools-4.0.1.tar.gz \
 && wget -O /tmp/pip.tgz https://pypi.python.org/packages/source/p/pip/pip-1.5.6.tar.gz \ 
 && cd /tmp && gunzip setuptools.tgz && tar -xf setuptools.tar && cd setuptools-* && /usr/local/bin/python setup.py install \
 && cd /tmp && gunzip pip.tgz && tar -xf pip.tar && cd pip-* && /usr/local/bin/python setup.py install \
 && rm -rf /tmp/* && opkg-cl  remove wget libpcre

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY cfn-signal requirements.txt /usr/src/app/
RUN /usr/local/bin/pip install -r requirements.txt

CMD ["/usr/src/app/cfn-signal"]

