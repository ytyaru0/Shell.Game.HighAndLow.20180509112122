# このソフトウェアについて

Bashで High & Low ゲーム。

# 概要

次の数値を予想するゲーム。

* `0`〜`9`の10件の数値がランダムで表示される
* 次に出る数値がそれより大きいか小さいかを当てる

# 実行

```sh
$ ./HiLo.sh
```

# 画面

```sh
0% 0 (0/0)

  5

High or Low ? [h/l]:
```

* 中央に表示された数値より大きいと思うなら`h`、小さいと思うなら`l`を入力する
* 勝率, 連勝敗数, (勝利数/勝負数)が表示される

## 終了

`q`を入力すると終了。

```sh
High or Low ? [h/l]: q
```

## ゲーム進行


`h`か`l`を入力するとゲームが進む。

```sh
High or Low ? [h/l]: h
```

```sh
High or Low ? [h/l]: l
```

### 勝利

```sh
100.00% +1 (1/1)

  5  7

WIN!  some key press !
```

### 敗北

```sh
0.00% -1 (0/1)

  5  7

LOSE...  some key press !
```


# 開発環境

* [Raspberry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 3 Model B
    * [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) GNU/Linux 8.0 (jessie)
        * bash 4.3.30

# ライセンス

このソフトウェアはCC0ライセンスである。

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)
