
# hosino-todo
[環境構築の資料](https://github.com/takatoshiinaoka/hosino-todo/tree/%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89)

#  デプロイ
* AzureのACRでレジストリを作成し、Dockerイメージのプッシュ
* AzureのApp Service　for Containerを作成し、デプロイ
* 表示をロケットから、Hello Worldへ変更


----

# Azure Container Registory作成
Azureで「コンテナレジストリ」と検索し、作成します。

リソースグループは新規作成。

## ローカルでDockerイメージ作成 &レジストリログイン &プッシュ
「hello-world」という**タグ**をつけてビルドを実行し、dockerイメージを作成。

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
Azureの ホーム > コンテナレジストリ > レジストリ名  に移動

リポジトリに自分のイメージがプッシュされているか確認する。

----

# App Serviceの作成
Azureで、リソースの作成→Webアプリ 作成

リソースグループはコンテナレジストリと同じものを使用。公開 は、Dockerコンテナーを選択しましょう。

Dockerに移動し、先ほどプッシュしたイメージを選択。

## 環境変数の設定

App Serviceの構成→「新しいアプリケーションの設定」に、docker-compose.ymlに書かれている SECRET_KEY を設定します。

## 確認
起動するまでに少し時間がかかりますが、これでデプロイ先でもロケット打ち上げ成功です。

----

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


## ルーティングの設定１
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

## ルーティングの設定２
サーバにアクセス→プロジェクトのurls→アプリのurls の流れですが、アプリのurlsが無いので新規作成します。

↓コマンドでファイルを新規作成。GUIで作成してもOKです。
```
touch アプリ名/urls.py
```

## ルーティングの設定３
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

## viewsの関数を作成
views.pyにindex())関数の処理を記述します。

↓アプリ名/viwes.py
```
from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World')
```


## 動作確認
変更を確認してみましょう。

```
docker compose up
```
を実行し、[localhost:8000/hello](http://localhost:8000/hello)にアクセス。

「Hello World」と表示できたら成功です。

## 再デプロイ
では、もう一度デプロイをしてみましょう。 ※hello-world-2 に注意
```
docker build -t hello-world .
docker tag hello-world レジストリ名.azurecr.io/hello-world-2
docker push レジストリ名.azurecr.io/hello-world-2
```
今回は、前回からの差分のみプッシュされるので、すぐに終わります。

先ほど作成した、App Serviceに移動します。

デプロイセンターに移動し、イメージで「hello-world-2」を選択し、**保存**します。

設定が保存されると再デプロイされます。デプロイするのに時間がかかります。

デプロイが終わると、https://サーバドメイン/hello にアクセスし、「Hello World」と表示されたら成功です。


## 次へ
次はCI/CIです。

ブランチを切り替えて、次の資料に進みましょう。
```
git add .
git commit -m "deploy done"
git push
git checkout -b CI/CD
```

[CI/CDの資料](https://github.com/takatoshiinaoka/hosino-todo/tree/CI/CD)

