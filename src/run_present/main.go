// Starts nginx, then the presentation in /usr/bin/present
//
// +build run_present
package main

import (
	"fmt"
	"log"
	"os/exec"
)


// launch the system
func main() {
	var (
		nginx *exec.Cmd
		present *exec.Cmd
		err error
	)

	fmt.Printf("starting nginx in /usr/bin/nginx ...\n")
	nginx = exec.Command("nginx")
	err = nginx.Start()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("starting bin/present ...\n")
	present = exec.Command("bin/present")
	err = present.Start()
	if err != nil {
		log.Fatal(err)
	}
}
