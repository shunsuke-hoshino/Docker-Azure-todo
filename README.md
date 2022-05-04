# hosino-todo
## Azure Container Registory作成
Azureで「コンテナレジストリ」と検索し、作成します。

リソースグループは新規作成。

## ローカルでDockerイメージ作成 &レジストリログイン &プッシュ
「hello-world」という**タグ**をつけてビルドを実行。dockerイメージを作成。

```
docker build -t hello-world . 
```

コンテナレジストリにログイン
```
docker login hosinotodo.azurecr.io
```

レジストリにプッシュする

## リポジトリ確認
Azureの ホーム>コンテナレジストリ>レジストリ名 のリポジトリに自分のイメージがプッシュされているか確認する。

# Web appの作成
Azureで、リソースの作成→Webアプリ 作成

リソースグループはコンテナレジストリと同じものを使用しましょう。

公開 は、Dockerコンテナーを選択しましょう。

Dockerに移動し、先ほどプッシュしたイメージを選択。

起動するまでに少し時間がかかりますが、これでデプロイ先でもロケット打ち上げ成功です。

# Hello world