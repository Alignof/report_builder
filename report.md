---
title: "example of report_builder"
author: Author Name
date: \today
listings: True
codeBlockCaptions: True
---

# 概要
このレポジトリは，手元のmarkdownをpandocを用いてpdfに変換するためのものである．
以下にbuildの方法と記法の例を示す．

# buildの方法
まず，レポジトリをcloneする．  
$ git clone https://github.com/Alignof/report_builder.git  
次にdocker imageをbuildする．  
$ docker build . -t report_builder  
作業ディレクトリにreport.mdというファイルを作成し，build_config.yamlという設定ファイルを置く．
以下を実行してpdfを生成．  
$ sudo docker run --rm --volume "$(pwd):/data" report_builder  
以上でpdfが生成される．

# 記法の例
以下に記法の例を示す．

## これが見出し
数式は\$\$ \$\$で囲むことで$$\sum_{\alpha=1}^{4} x_\alpha y_\alpha = 1\times1 + 2\times3 + 3\times5 + 5\times3 = 1+6+15+15 = 37$$
のように表現できる．  
これが**太字**で，これが*italic*である．取り消し線は~~こうする~~．
urlは[このように](https://github.com/Alignof/report_builder.git)表す．

- これが
- 列挙で
- ある．
    - 入れ子にも
    - 出来る．

1. 数字を 
1. 用いた
1. 列挙は
    1. この
    1. 通り．

脚注はこのように[^1]書く．

[^1]:こんな風に

分かりづらいかもしれないが，

> 引用はこのように\>を頭につける．

一段下がっているのが分かる．

以下が，水平線．

---

## 表

[@tbl:example]に表の例を示す．

name        image color 
------      ------
酒井桃音    pink   
竹内黄奈子  yellow 
浦上紫苑    purple 
河鍋蒼      blue   
菱川翠玉    green  

: 表の例 {#tbl:example}

## コードブロック
[@lst:example]にコードブロックの例を示す．
```{.python #lst:example caption="コードブロックの例" title="codeblock.py"}
def MonteCarlo():
    cnt = 0
    X_RANGE = 2
    Y_RANGE = 6
    LOOP_TIME = 2000

    for _i in range(LOOP_TIME):
        x = np.random.rand() * X_RANGE
        y = np.random.rand() * Y_RANGE
        if is_under_a_curve(x, y):
            cnt += 1
    print("{:.10f}".format((X_RANGE * Y_RANGE) * cnt/LOOP_TIME))
```


