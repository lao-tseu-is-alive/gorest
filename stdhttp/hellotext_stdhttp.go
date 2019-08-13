package main

import (
	"log"
	"net/http"
)

const (
	HelloWorldString = "Hello from Golang API TEST\n"
	adr              = ":8080"
)

func main() {
	var (
		HelloWorldBytes = []byte(HelloWorldString)
	)
	http.HandleFunc("/plaintext", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/plain; charset=utf-8")
		w.Header().Set("Server", "go")
		w.WriteHeader(http.StatusOK)
		w.Write(HelloWorldBytes)
	})

	log.Fatal(http.ListenAndServe(adr, nil))
}
