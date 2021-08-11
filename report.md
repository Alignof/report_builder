---
title: "数値計算 第7回課題"
author: 高名 典雅
date: \today
listings: True
codeBlockCaptions: True
---

# mintedのテスト
\begin{longlisting}
\begin{myminted}{cpp}{example}
#include <stdio.h>
#include <omp.h>
#define N 1000000
int main(void){
    int i,j,count0;
    int a[N];
    for(i=0;i<N;i++) a[i]=i%100;
    for(l=0;l<100000;l++){
        coutn0=0;
        #pragma omp parallel for reduction(+:count0) num\_threads(4)
        for(i=0;i<N;i++){
            if(a[i]==0) count0++;
        }
    }
    printf("count0:\%d\n",count0);

    return 0;
}
\end{myminted}
\caption{リストの例}
\label{lst:}
\end{longlisting}

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

