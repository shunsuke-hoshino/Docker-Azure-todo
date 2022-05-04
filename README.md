# hosino-todo

以下のコマンドでpythonイメージから作成されたコンテナでDjangoのプロジェクトを作成する。
```
docker compose run web django-admin.py startproject hosinoproject .
```

以下のコマンドでDjangoのアプリを作成する。
```
docker compose run web django-admin.py startapp hosinoapp 
```