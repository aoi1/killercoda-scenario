Deploymentが壊れてしまいました。NGINXにアクセスできないことを確認しましょう。

```
kubectl port-forward deployment/my-app 8080:80
```

以下が結果として表示されることを確認したら次に進んでください。
```
error: unable to forward port because pod is not running. Current status=Pending
```
