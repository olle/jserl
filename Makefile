
.PHONY: compile

compile:
	@rebar compile

clean:
	@rm -rf ebin

run:
	@erl -pa deps/*/ebin ebin/
