package main

import (
	"net/http"
	"log"
)

const (
	HelloWorldString = "Hello from Golang API TEST\n"
	adr = "localhost:8080"
)

func main() {
	var (
		HelloWorldBytes = []byte(HelloWorldString)
	)
	http.HandleFunc("/plaintext", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Server", "go")
		w.Header().Set("Content-Type", "text/plain")
		w.Write(HelloWorldBytes)
	})

	log.Fatal(http.ListenAndServe(adr, nil))
}
