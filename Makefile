all: ruby crystal go rust client benchmarker

# --- Ruby ---
ruby: rails sinatra roda

# Rails
rails:
	cd ruby/rails; bundle update
	cd ruby/rails; bundle install --path vendor/bundle
	ln -s -f ../ruby/rails/bin/server_ruby_rails bin/.

# Sinatra
sinatra:
	cd ruby/sinatra; bundle update
	cd ruby/sinatra; bundle install --path vendor/bundle
	ln -s -f ../ruby/sinatra/server_ruby_sinatra bin/.

# Roda
roda:
	cd ruby/roda; bundle update
	cd ruby/roda; bundle install --path vendor/bundle
	ln -s -f ../ruby/roda/server_ruby_roda bin/.

# --- Crystal ---
crystal: kemal route_cr

# Kemal
kemal: crystal/kemal/src/server.cr
	cd crystal/kemal; shards build
	ln -s -f ../crystal/kemal/bin/server_crystal_kemal bin/.

# route.cr
route_cr: crystal/route.cr/src/server.cr
	cd crystal/route.cr; shards build
	ln -s -f ../crystal/route.cr/bin/server_crystal_route_cr bin/.

# --- Go ---
go: echo gorilla-mux

# Echo
echo:
	go get -u github.com/labstack/echo
	cd go/echo; go build -o server_go_echo main.go
	ln -s -f ../go/echo/server_go_echo bin/.

# gorilla/mux
gorilla-mux:
	go get -u github.com/gorilla/mux
	cd go/gorilla-mux; go build -o server_go_gorilla_mux main.go
	ln -s -f ../go/gorilla-mux/server_go_gorilla_mux bin/.

# --- Rust ---
rust: iron nickel

# IRON
iron:
	cd rust/iron; cargo update
	cd rust/iron; cargo build --release
	ln -s -f ../rust/iron/target/release/server_rust_iron bin/.

# nickel.rs
nickel:
	cd rust/nickel; cargo update
	cd rust/nickel; cargo build --release
	ln -s -f ../rust/nickel/target/release/server_rust_nickel bin/.

# --- Benchmarker ---
# client
client: benchmarker/src/client.cr
	cd benchmarker; crystal build src/client.cr -o bin/client --release
	ln -s -f ../benchmarker/bin/client bin/.

# benchmarker
benchmarker: benchmarker/src/benchmarker.cr
	cd benchmarker; crystal build src/benchmarker.cr -o bin/benchmarker --release
	ln -s -f ../benchmarker/bin/benchmarker bin/.

# Cleaning all executables
clean:
	rm -rf bin/*
