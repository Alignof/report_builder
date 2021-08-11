FROM pandoc/latex:2.11.2
ENTRYPOINT ["sh", "/usr/lib/build.sh"]
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
RUN apk add python3 py3-pip py3-pygments
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install pandocfilters
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.8.4/pandoc-crossref-Linux.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
COPY ./minted_filter.py /usr/lib/
COPY ./listings-setup.tex /usr/lib/
COPY ./build.sh /usr/lib/
