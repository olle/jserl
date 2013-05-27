
.PHONY: compile

compile:
	@rebar compile

clean:
	@rm -rf ebin

run:
	@erl -pa `pwd` ./ebin/ ./deps/*/ebin/
