-module(tnesia_tql_api).

-export([
	 query/1
	]).

-include("tnesia.hrl").
-include("types.hrl").

%%====================================================================
%% Main API
%%====================================================================

%%--------------------------------------------------------------------
%% query
%%--------------------------------------------------------------------
-spec query(string()) -> list().
query(Query) ->

    {ok, Result} = 
    	?TQL_LINTER:check_and_run(
    	   Query,
    	   [{syntax, {?TQL_SCANNER, string}},
    	    {semantics, {?TQL_PARSER, parse}},
    	    {evaluate, {?TQL_EVALUATOR, eval}},
	    {format, {?TQL_FORMATTER, json}}]),
    
    Result.
    
%%====================================================================
%% Internal Functions
%%====================================================================

