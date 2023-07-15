# このリポジトリは？

GitHubActionsでbuildしたdockerイメージをECRにPUSHできるかの検証用として作成した。

アプリはgolangで作成。webでアクセスする表示される。


以下の記事を参考にした。
https://koya-tech.com/ecr-githubactions/

GitHubActionsのSECRETSに以下を設定する。

AWS_ROLE_ARN
ECR_REPOSITORY_URL

以下のコマンドを使用して表示すること。

terraform state show aws_ecr_repository.sample
terraform state show aws_iam_role.github