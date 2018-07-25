package main

import (
	"net/http"
	"log"
)

func main() {
	const (
		HelloWorldString = "Hello from Golang net/http API TEST\n"
	)
	var (
		HelloWorldBytes = []byte(HelloWorldString)
	)
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Server", "go")
		w.Header().Set("Content-Type", "text/plain")
		w.Write(HelloWorldBytes)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
