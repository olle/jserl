
.PHONY: compile

compile:
	@rebar compile

deps:
	@rebar get-deps

clean:
	@rm -rf ebin

run:
	@erl -pa `pwd` ./ebin/ ./deps/*/ebin/
