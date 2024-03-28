package main

import (
	_ "embed"
	"log"
	"net/http"
	"os"
)

//go:embed resources/setup
var data []byte

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, _ = w.Write(data)
	})


	log.Println("listening on", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

