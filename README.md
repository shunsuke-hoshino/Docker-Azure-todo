# hosino-todo

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
----
# シェルスクリプト実行権限付与
docker-compose.ymlがstartup.shを実行できるように権限を付与します。
```
chmod +x startup.sh 
```
## 生成されたファイルの所有者を変更
いるかわからんが
```
sudo chown -R $USER:$USER .
```
----
## settings.pyを編集
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

----
.gitignoreの1番下に書かれている「docker-compose.yml」のコメントを外します。

※docker-compose.ymlはSECRET_KEYが書かれており、公開してはいけません。

↓.gitignore
```
docker-compose.yml
```

----

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
