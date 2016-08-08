# SWRC Fit の Mac OS X へのインストール

1. [Homebrew をインストールするための条件](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Installation.md#requirements)を確認して、[Xcode](https://itunes.apple.com/jp/app/xcode/id497799835)をインストールする。
2. [Homebrew](http://brew.sh/index_ja.html) をインストールする。
3. [ターミナル](https://ja.wikipedia.org/wiki/%E3%82%BF%E3%83%BC%E3%83%9F%E3%83%8A%E3%83%AB_(Mac))で `java -version` を実行して、Java がインストールされているかどうかを確認する。`java: command not found` というメッセージが表示されたら、[Java の最新バージョンをダウンロード](https://www.java.com/download/)してインストールする。
4. ターミナルで `brew tap homebrew/science; brew install swrcfit` を実行する。

最新のバージョンへのアップグレードは、`brew update; brew upgrade` を実行する。

swrcfit を実行した時に `warning: 'leasqr' undefined near line ... column ...` のエラーが出る時には、ターミナルで次のコマンドを実行してください。

```
octave -q --eval "pkg install -forge struct optim"
```

[Gluplot でグラフを描く](graph.md)ためには、環境変数 GNUTERM を x11, qt, aqua の中から選んで設定する必要がある。たとえば、 `GNUTERM=qt` のように設定する。

----
[SWRC Fit マニュアル](README.md)
