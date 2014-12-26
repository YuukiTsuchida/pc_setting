# デフォルトのvim機能

##行途中改行に移動
1行が中が過ぎると途中で改行されるので即座に移動する方法
gj:表示状態の1段下に移動
gk:表示状態の1段上に移動

# vimの各プラグインの利用方法など設定周りの記載

## AlpacaTags
ctagのヘルパー
[github](https://github.com/alpaca-tc/alpaca_tags)
[参考資料](http://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb)

コマンド
:TagsUpdate
Git配下のtagsを生成します。
:TagsBundle
Gemfileからgemのtagsを生成します。
:TagsSet
生成したtagsを読み込みます。
:Unite tags
uniteを使ってtagを操作します


## switch.vim
[github](https://github.com/AndrewRadev/switch.vim)

バインドされた特定キーワードを切り替えるプラグイン
例：true→false

[-]で切り替えるようにしている。


## caw.vim
ソースのコメントイン・アウトの切り替えるプラグイン
[\sc]に割り当てている

## unite-rails
Uniteの拡張
railsのmodel, view, controllerへの移動を楽にする

現状キーバインドは設定してない
