# 環境構築

* Djangoプロジェクト作成
* Djangoアプリ作成


以下のコマンドでpythonイメージから作成されたコンテナでDjangoのプロジェクトを作成する。
```
docker compose run web django-admin.py startproject hosinoproject .
```
以下のコマンドでDjangoのアプリを作成する。
```
docker compose run web django-admin.py startapp hosinoapp 
```
----

## シェルスクリプト実行権限付与
docker-compose.ymlがstartup.shを実行できるように権限を付与します。
```
chmod +x startup.sh 
```
## 生成されたファイルの所有者を変更
いるかわからんので次に飛ばしてエラーが起きたら戻ってきてね！
```
sudo chown -R $USER:$USER .
```
----
## 環境変数の設定
SECRET_KEYは公開してはいけないので環境変数を使います。

**settings.py** の SECRET_KEY を **docker-compose.yml** の SECRET_KEY に記述します。

↓docker-compose.yml
```
environment:
      - SECRET_KEY= ここにsettings.pyに書いてあるSECRET_KEYを記述
```

↓settings.py
```
import environ
import os

env = environ.Env()
env.read_env(os.path.join('.env'))
:
SECRET_KEY = env('SECRET_KEY')
```

## docker-compose.ymlをGit管理から外す
.gitignoreの1番下に書かれている「docker-compose.yml」のコメントを外します。

※docker-compose.ymlはSECRET_KEYが書かれており、公開してはいけません。

↓.gitignore
```
docker-compose.yml
```

----

## サーバホストを指定
ホストヘッダー攻撃対策で、ALLOWED_HOSTSにはWebサービスを提供するドメイン名を指定する必要があります。ついでに言語とタイムゾーンも指定。
```
ALLOWED_HOSTS = ['*']
:
LANGUAGE_CODE = 'ja'
TIME_ZONE = 'Asia/Tokyo'
```

## ロケット打ち上げ
```
docker compose build 
dokcer compose up
```
ロケットが打ち上がったら成功です。

停止：　control + c
```
docker compose down
```



# 次へ
次はデプロイです。

ブランチを切り替えて、次へ進みましょう。
```
git add .
git commit -m "環境構築 done"
git push
git checkout -b デプロイ
```

[デプロイの資料](https://github.com/takatoshiinaoka/hosino-todo/tree/%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4)
