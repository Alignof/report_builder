pandoc -d build_config.yaml &&\
    lualatex -shell-escape tmp.tex &&\
    mv tmp.pdf 17423.pdf &&\
    rm -rf tmp* *.log _minted-tmp
