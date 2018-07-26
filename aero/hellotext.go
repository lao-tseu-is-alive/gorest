package main

import "github.com/aerogo/aero"

func main() {
	const HelloWorldString = "Hello from Golang Aero API TEST\n"

	app := aero.New()

	app.Get("/", func(context *aero.Context) string {
		return context.Text(HelloWorldString)
	})

	app.Run()

}
