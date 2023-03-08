package main
import (
        "fmt"
        "log"
        "net/http"
        "os"
        "os/exec"
)
func handler(w http.ResponseWriter, r *http.Request) {
        log.Print("dbt: received a request")
cmd := exec.Command("/bin/sh", "script.sh")
        cmd.Stdout = os.Stdout
 cmd.Stderr = os.Stderr
 err := cmd.Run()
 if err != nil {
  log.Fatalf("cmd.Run() failed with %s\n", err)
 }
}

func healthHandler(w http.ResponseWriter, r *http.Request){
        if r.URL.Path != "/health" {
                http.NotFound(w, r)
                return
        }
        log.Print("dbt: health check OK")
        w.WriteHeader(http.StatusOK)
}

func main() {
        log.Print("dbt: starting server...")
http.HandleFunc("/", handler)
http.HandleFunc("/health", healthHandler)
port := os.Getenv("PORT")
        if port == "" {
                port = "8080"
        }
log.Printf("dbt: listening on %s", port)
        log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}