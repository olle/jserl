
.PHONY: compile

compile:
	@rebar compile

deps:
	@rebar get-deps

clean:
	@rm -rf ebin

clean-deps:
	@rm -rf deps

test: compile
	@rebar eunit

run: compile test
	@erl -pa `pwd` ./ebin/ ./deps/*/ebin/
