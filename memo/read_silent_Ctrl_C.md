# 終了後

https://rcmdnk.com/blog/2014/01/22/computer-bash/

`read -s`で待機中に`Ctrl+C`で終了すると、以降入力文字が表示されなくなってしまう。終了時、`stty echo`することで解決する。

```sh
trap "stty echo;return" 1 2 3 15
```

