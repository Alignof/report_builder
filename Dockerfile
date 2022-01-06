FROM pandoc/latex:2.16.2
ENTRYPOINT ["sh", "/usr/lib/build.sh"]
RUN tlmgr update --self --all
RUN tlmgr install \
      ipaex \
      haranoaji \
      environ \
      selnolig \
      minted \
      fvextra \
      catchfile \
      xstring \
      accsupp \
      tcolorbox \
      luatexja
RUN apk add python3 py3-pip 
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN wget --no-check-certificate -O pygments-rs https://github.com/Alignof/pygments-rs/tarball/master \
    && mkdir pygments \
    && tar xzf pygments-rs -C pygments --strip-components 1 \
    && cd pygments \
    && python setup.py install \
    && cd .. \
    && rm -rf pygments*
RUN pip3 install pandocfilters
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.12.1a/pandoc-crossref-Linux.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
COPY ./minted_filter.py /usr/lib/
COPY ./listings-setup.tex /usr/lib/
COPY ./build.sh /usr/lib/
