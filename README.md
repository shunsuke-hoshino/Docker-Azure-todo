# CI/CD


## Githubの確認
まずは、 **最新のコードがGithubにプッシュ** できているか確認。

## デプロイセンターの設定
* App Service/デプロイセンター で 「Github Actions」 を選択。
* 「組織・リポジトリ・ブランチ」を選択し、保存。
* 自分のリポジトリへアクセス[Github](https://github.com)
*  Actions へ移動。上手くいけば、CI/CDが構築できてワークフローを確認できます。
* 緑のチェックが表示されたら成功です。

## 表示の変更 
表示を「Hello World」から他のものに変更してGithubにプッシュしてみましょう。

プッシュするともう一度、Github Actions が実行されます。

上手くデプロイできていれば、表示が変更されているはずです。


## 次へ
次は、ToDoアプリの作成です。

ToDoアプリのブランチを作成移動し、次の資料に進みましょう。
```
git checkout -b ToDoアプリ
```

next:[ToDoアプリの資料](https://github.com/takatoshiinaoka/hosino-todo/blob/ToDo%E3%82%A2%E3%83%97%E3%83%AA/README.md)
