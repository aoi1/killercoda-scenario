// ハンズオン用のデモアプリ。自分のPod名とバージョンだけを表示する。
package main

import (
	"html/template"
	"log"
	"net/http"
	"os"
)

// version はビルド時に -ldflags "-X main.version=v1" で埋め込む
var version = "dev"

var page = template.Must(template.New("page").Parse(`<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hello Kubernetes</title>
<style>
  body { margin: 0; min-height: 100vh; display: grid; place-items: center;
         font-family: sans-serif; background: {{.Color}}; color: #fff; }
  main { text-align: center; padding: 16px; }
  .label { font-size: 1.2rem; opacity: .8; margin: 0; }
  .value { font-size: 2.5rem; font-weight: bold; margin: 0 0 32px; word-break: break-all; }
</style>
</head>
<body>
<main>
  <p class="label">Pod名</p>
  <p class="value">{{.PodName}}</p>
  <p class="label">バージョン</p>
  <p class="value">{{.Version}}</p>
</main>
</body>
</html>
`))

func main() {
	podName := os.Getenv("POD_NAME")
	if podName == "" {
		podName = "（POD_NAMEが設定されていません）"
	}

	// バージョンが変わったことがひと目でわかるように背景色を変える
	color := "#326ce5"
	if version == "v2" {
		color = "#2e7d32"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := struct{ PodName, Version, Color string }{podName, version, color}
		if err := page.Execute(w, data); err != nil {
			log.Println(err)
		}
	})
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("ok"))
	})

	log.Printf("listening on :8080 (version=%s, pod=%s)", version, podName)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
