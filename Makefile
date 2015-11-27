
.PHONY: compile

compile: priv/socket.io.js
	@rebar compile

priv/socket.io.js: node_modules/
	@cp ./node_modules/socket.io-client/socket.io.js $@

node_modules/:
	@npm install

deps:
	@rebar get-deps

clean:
	@rm -rf ebin

run: compile
	@erl -pa `pwd` ./ebin/ ./deps/*/ebin/
