FROM pandoc/latex:2.11.2
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
RUN tlmgr update --self --all
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.8.4/pandoc-crossref-Linux.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
