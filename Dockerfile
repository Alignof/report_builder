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
RUN apk add python3 py3-pygments
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.8.4/pandoc-crossref-Linux.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
RUN wget -O pandoc-minted https://github.com/nick-ulle/pandoc-minted/blob/d8416ee1594268036157f8bf0c10abc184eb86b5/pandoc-minted.py \
  && mv pandoc-minted /usr/lib/ 
