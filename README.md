# CI/CD

まずは、最新のコードがGithubにプッシュできているか確認。

App Service の デプロイセンター で Github Actions を選択。

組織・リポジトリ・ブランチを選択し、保存。

[github](https://github.com)で自分のリポジトリ→ Actions へ移動。

上手くいけば、CI/CDが構築できてワークフローを確認できます。

緑のチェックが表示されたら成功です。

----
表示を「Hello World」から他のものに変更してGithubにプッシュしてみましょう。

プッシュするともう一度、Github Actions が実行されます。

上手くデプロイできていれば、表示が変更されているはずです。