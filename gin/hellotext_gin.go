package main

import (
	"github.com/gin-gonic/gin"
		)

const (
	HelloWorldString = "Hello from Golang API TEST\n"
	adr = "localhost:8080"
)

func main() {
	gin.SetMode(gin.ReleaseMode)
	r := gin.New()
	serverHeader := []string{"Gin"}
	r.Use(func(c *gin.Context) {
		c.Writer.Header()["Server"] = serverHeader
	})
	r.GET("/plaintext", func(c *gin.Context) {
		c.String(200, HelloWorldString)
	})
	r.Run(adr)
}