FROM pandoc/latex:2.9.2.1
RUN tlmgr install \
      ipaex \
      luatexja \
    tlmgr update latex
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.4/pandoc-crossref-Linux-2.9.2.1.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
