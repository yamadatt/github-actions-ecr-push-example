package main

import (
	"fmt"
	"net/http"
)

func handler(writer http.ResponseWriter, _ *http.Request) {
	fmt.Fprint(writer, "Hello World")
}

func main() {
	fmt.Println("testtesttest")
	http.HandleFunc("/", handler)
	http.ListenAndServe(":80", nil)
}
