package main

import (
	"context"
	"encoding/json"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/gorilla/mux"
	"go.uber.org/zap"
)

func main() {
	addr := "0.0.0.0:3000"

	loggerCfg := zap.NewProductionConfig()
	loggerCfg.DisableCaller = true
	logger, _ := loggerCfg.Build()
	defer logger.Sync()
	logger.Info("boot",
		zap.String("version", "0.0.1"),
		zap.String("addr", addr))

	r := mux.NewRouter()

	// log middleware
	r.Use(func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			logger.Info("http",
				zap.String("uri", r.RequestURI),
				zap.String("method", r.Method),
				zap.String("agent", r.UserAgent()),
			)

			next.ServeHTTP(w, r)
		})
	})

	r.HandleFunc("/v1/json", RootHandler).Methods(http.MethodPost)

	srv := &http.Server{
		Handler:      r,
		Addr:         addr,
		WriteTimeout: 30 * time.Second,
		ReadTimeout:  30 * time.Second,
	}

	go func() {
		if err := srv.ListenAndServe(); err != nil {
			logger.Error("exit", zap.Error(err))
		}
	}()

	// graceful shutdown with deadline
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt)
	<-c

	ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
	defer cancel()
	srv.Shutdown(ctx)
}

func RootHandler(w http.ResponseWriter, r *http.Request) {
	// TODO: change to struct based
	var payload map[string]interface{}
	err := json.NewDecoder(r.Body).Decode(&payload)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		w.Write([]byte(err.Error()))
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(payload)
}
