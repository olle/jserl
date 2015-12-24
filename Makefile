
.PHONY: compile

compile:
	@rebar compile

deps:
	@rebar get-deps

clean:
	@rm -rf ebin

clean-deps:
	@rm -rf deps

run: compile
	@erl -pa `pwd` ./ebin/ ./deps/*/ebin/
