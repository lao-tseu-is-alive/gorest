package main

import "github.com/aerogo/aero"

func main() {
	const HelloWorldString = "Hello from Golang API TEST\n"
	app := aero.New()

	app.Get("/plaintext", func(context *aero.Context) string {
		return context.Text(HelloWorldString)
	})

	app.Run()

}
