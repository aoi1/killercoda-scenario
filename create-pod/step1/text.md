
`my-pod` という名前のPodを作ってください

参考：
```
cat <<EOF > my-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
spec:
  containers:
  - name: nginx-container
    image: nginx:1.27.0
    ports:
    - containerPort: 80
EOF
```
