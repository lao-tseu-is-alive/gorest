package main

import (
	"github.com/valyala/fasthttp"
	"log"
)
const (
	HelloWorldString = "Hello from Golang API TEST\n"
	adr = "localhost:8080"
)
var (
	HelloWorldBytes = []byte(HelloWorldString)
)

func main() {

	err := fasthttp.ListenAndServe(adr, func(ctx *fasthttp.RequestCtx) {
		ctx.SetContentType("text/plain")
		ctx.Write(HelloWorldBytes)
	});
	if err != nil {
		log.Fatalf("Error in ListenAndServe: %s", err)
	}

}
func mainHandler(ctx *fasthttp.RequestCtx)  {
	path := ctx.Path()
	switch string(path) {
	case "/plaintext":
		ctx.SetContentType("text/plain")
		ctx.Write(HelloWorldBytes)
	default:
		ctx.Error("unexpected path", fasthttp.StatusBadRequest)
	}
}
