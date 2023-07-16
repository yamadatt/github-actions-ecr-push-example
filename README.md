# このリポジトリは？

GitHubActionsでbuildしたdockerイメージをECRにPUSHできるかの検証用として作成した。

アプリはgolangで作成。webでアクセスする表示される。

## GitHubActionsのSECRETS設定

GitHubActionsのSECRETSに以下を設定する。

- AWS_ROLE_ARN
- ECR_REPOSITORY_URL

以下のコマンドを使用して```ECR_REPOSITORY_URL```表示すること。

```
terraform state show aws_ecr_repository.sample
```

iamで```AWS_ROLE_ARN```を表示する。

```
terraform state show aws_iam_role.github
```

## 参考記事

以下の記事を参考にした。

[GithubActionsでECRにコンテナをデプロイする方法【Terraform】 \| しーしゃーぱー日記](https://koya-tech.com/ecr-githubactions/)
