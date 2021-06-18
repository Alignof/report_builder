---
title: "数値計算 第7回課題"
author: 高名 典雅
date: \today
listings: True
codeBlockCaptions: True
---

# 掃き出し法の実装
掃き出し法の実装を示す．
```{.python caption="掃き出し法の実装"}
b = [[2, 3, 4, 6],
     [3, 5, 2, 5],
     [4, 3, 30, 32]]

N = 3
def sweep():
    # 0 .. N
    for k in range(0, N):
        # 0 .. N+1
        for x in range(k+1, N+1):
            b[k][x] = b[k][x] / b[k][k]
            # 0 .. N
            for y in range(0, N):
                if y != k:
                    b[y][x] = b[y][x] - b[k][x] * b[y][k]
```


# ガウスの消去法の実装
ガウスの消去法の実装を示す．
```{.python caption="ガウスの消去法の実装"}
def gauss():
    # 0 .. N
    for k in range(0, N):
        # k .. N+1
        for x in range(k, N+1):
            b[k][x] = b[k][x] / b[k][k]
            # k+1 .. N
            for y in range(k+1, N):
                if y != k:
                    b[y][x] = b[y][x] - b[k][x] * b[y][k]
```

