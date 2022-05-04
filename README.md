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
```
docker tag hello-world レジストリ名.azurecr.io/hello-world
docker push レジストリ名.azurecr.io/hello-world
```

## リポジトリ確認
Azureの ホーム>コンテナレジストリ>レジストリ名 のリポジトリに自分のイメージがプッシュされているか確認する。

# Web appの作成
Azureで、リソースの作成→Webアプリ 作成

リソースグループはコンテナレジストリと同じものを使用。公開 は、Dockerコンテナーを選択しましょう。

Dockerに移動し、先ほどプッシュしたイメージを選択。

ここで、環境変数の設定を行います。

App Serviceの構成から「新しいアプリケーションの設定」をクリックし、docker-compose.ymlに書かれている SECRET_KEY を設置します。

起動するまでに少し時間がかかりますが、これでデプロイ先でもロケット打ち上げ成功です。

# Hello world
次に、ロケットの画面ではなく、「Helloworld」と表示されるように変更します。

apps.pyに記述された、アプリ名をsettings.pyに登録します。

↓アプリ/apps.py
```
name = 'アプリ名'
```

↓プロジェクト/settings.py
```
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    #追加
    'アプリ名',
]
```

----

次にルーティングの設定を行います。
サーバにアクセスされた時にアプリのurls.pyを使用する設定を記入します。

プロジェクト/urls.py
```
from django.contrib import admin
from django.urls import path, include # include 追加

urlpatterns = [
    path('admin/', admin.site.urls),
    # 追加
    path('', include('アプリ名.urls')),
]
```
----
サーバにアクセス→プロジェクトのurls→アプリのurls の流れですが、アプリのurlsが無いので新規作成します。

↓コマンドでファイルを新規作成。GUIで作成してもOKです。
```
touch アプリ名/urls.py
```
----
サーバに、https://サーバドメイン/hello のアクセスが来たら

views.pyのindex()関数を呼び出すように設定します。

↓アプリ名/urls.py
```
from django.urls import path

from . import views

urlpatterns = [
    path('hello', views.index),
]
```
----
views.pyにindex())関数の処理を記述します。

↓アプリ名/viwes.py
```
from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World')
```

----
変更を確認してみましょう。

```
docker compose up
```
を実行し、[localhost:8000/hello](http://localhost:8000/hello)にアクセス。

「Hello World」と表示できたら成功です。

----
では、もう一度デプロイをしてみましょう。
```
docker build -t hello-world .
docker tag hello-world レジストリ名.azurecr.io/hello-world-2
docker push レジストリ名.azurecr.io/hello-world-2
```
今回は、前回からの差分のみプッシュされるので、すぐに終わります。

----
先ほど作成した、App Serviceに移動します。

デプロイセンターに移動し、イメージで「hello-world-2」を選択し、**保存**します。

設定が保存されると再デプロイされます。デプロイするのに時間がかかります。

デプロイが終わると、https://サーバドメイン/hello にアクセスし、「Hello World」と表示されたら成功です。

## 次へ
次はCI/CIです。

ToDoアプリのブランチを作成移動し、次の資料に進みましょう。
```
git add .
git commit -m "deploy done"
git push
git checkout -b CI/CD
```

[CI/CDの資料](https://github.com/takatoshiinaoka/hosino-todo/blob/CI/CD/README.md)
