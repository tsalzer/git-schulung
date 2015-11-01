// Starts nginx, then the presentation in /usr/bin/present
//
// +build run_present
package main

import (
	"fmt"
	"log"
	"os/exec"
	"os"
)


// start the nginx service.
func start_enginx() {
	var (
		nginx *exec.Cmd
		err error
	)

	nginx = exec.Command("/etc/init.d/nginx", "start")
	nginx.Stdout = os.Stdout
	nginx.Stderr = os.Stderr
	// err = nginx.Start()
	err = nginx.Run()
	if err != nil {
		log.Fatal(err)
	}
}

// start the nginx service.
func stop_enginx() {
	var (
		nginx *exec.Cmd
		err error
	)

	nginx = exec.Command("/etc/init.d/nginx", "stop")
	nginx.Stdout = os.Stdout
	nginx.Stderr = os.Stderr
	// err = nginx.Start()
	err = nginx.Run()
	if err != nil {
		log.Fatal(err)
	}
}

// launch the system
func main() {
	var (
		present *exec.Cmd
		err error
		hostname string
	)

	fmt.Printf("starting nginx service ...\n")
	start_enginx()

	hostname = os.Getenv("HOSTNAME")
	fmt.Printf("starting bin/present on %s ...\n", hostname)
	// present = exec.Command("bin/present",
	// 	fmt.Sprintf("-http=%s:3999", hostname),  "-play=false")
	present = exec.Command("bin/present",  "-play=false")
	present.Stdout = os.Stdout
	present.Stderr = os.Stderr
	err = present.Start()
	if err != nil {
		log.Fatal(err)
	}

	// now, wait for present to end...
	present.Wait()

	// stop nginx. Not really useful, as killing the process will prevent
	// us from getting here. But just in case the present process ends
	// naturally this would stop the reverse proxy.
	stop_enginx()
}
