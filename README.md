# 環境構築

## Djangoプロジェクト作成
以下のコマンドでpythonイメージから作成されたコンテナでDjangoのプロジェクトを作成する。
```
docker compose run web django-admin.py startproject hosinoproject .
```
## Djangoアプリ作成
以下のコマンドでDjangoのアプリを作成する。
```
docker compose run web django-admin.py startapp hosinoapp 
```

## シェルスクリプト実行権限付与
docker-compose.ymlがstartup.shを実行できるように権限を付与します。
```
chmod +x startup.sh 
```
## 生成されたファイルの所有者を変更
いるかわからんが
```
sudo chown -R $USER:$USER .
```

## サーバホストを指定
ホストヘッダー攻撃対策で、ALLOWED_HOSTSにはWebサービスを提供するドメイン名を指定する必要があります。ついでに言語とタイムゾーンも指定。
```
ALLOWED_HOSTS = ['*']
:
LANGUAGE_CODE = 'ja'
TIME_ZONE = 'Asia/Tokyo'
```

## ロケット打ち上げ成功！！
```
docker compose build 
dokcer compose up
docker compose down
```

# 次へ
次はデプロイです。

ブランチを切り替えて、次へ進みましょう。

[デプロイの資料](https://github.com/takatoshiinaoka/hosino-todo/blob/%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4/README.md)
