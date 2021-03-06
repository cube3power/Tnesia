%%====================================================================
%% Nonterminals
%%====================================================================
Nonterminals
query
select_query
select_fields
select_wheres
select_where
select_where_condition
select_where_time
select_where_order
select_where_limit
insert_query
insert_record_keys
insert_record_values
insert_records_values
delete_query
.

%%====================================================================
%% Terminals
%%====================================================================
Terminals
select
all
wildcard
from
since
till
order
limit
where
insert
into
delete
records
when
atom_value
list_values
comparator
conjunctive
direction
.

%%====================================================================
%% Rootsymbol
%%====================================================================
Rootsymbol query.

%%====================================================================
%% Rules
%%====================================================================
query ->
    select_query :
    '$1'.

query ->
    insert_query :
    '$1'.

query ->
    delete_query :
    '$1'.

%%--------------------------------------------------------------------
%% select query
%%--------------------------------------------------------------------
select_query ->
    select select_fields from atom_value :
    {select, [{timeline, '$4'}, {keys, '$2'}]}.

select_query ->
    select select_fields from atom_value where select_wheres:
    {select, [{timeline, '$4'}, {keys, '$2'}, {where, '$6'}]}.

select_fields ->
    wildcard :
    '$1'.

select_fields ->
    list_values :
    '$1'.

select_wheres ->
   select_where :
   ['$1'].

select_wheres ->
    select_where conjunctive select_where :
    ['$1', '$3'].

select_wheres ->
   select_wheres conjunctive select_wheres :
   lists:flatten(['$1', '$3']).

select_where ->
    select_where_condition :
    '$1'.

select_where ->
    select_where_time :
    '$1'.

select_where ->
    select_where_order :
    '$1'.

select_where ->
    select_where_limit :
    '$1'.

select_where_condition ->
    atom_value comparator atom_value :
    {condition, {'$1', '$2', '$3'}}.

select_where_time ->
    since atom_value till atom_value :
    {times, {'$2', '$4'}}.

select_where_order ->
    order direction :
    {order, '$2'}.

select_where_limit ->
    limit atom_value :
    {limit, '$2'}.

%%--------------------------------------------------------------------
%% insert query
%%--------------------------------------------------------------------
insert_query ->
    insert into atom_value insert_record_keys 
    records insert_records_values :
    {insert, [{timeline, '$3'}, {keys, '$4'}, {values, '$6'}]}.

insert_record_keys ->
    list_values :
    '$1'.

insert_record_values ->
    list_values :
    '$1'.

insert_records_values ->
    insert_record_values :
    ['$1'].

insert_records_values ->
    insert_record_values conjunctive insert_record_values :
    ['$1', '$3'].

insert_records_values ->
    insert_records_values conjunctive insert_records_values :
    lists:flatten(['$1', '$3']).
    
%%--------------------------------------------------------------------
%% delete query
%%--------------------------------------------------------------------
delete_query ->
    delete from atom_value when atom_value :
    {delete, [{timeline, '$3'}, {record_time, '$5'}]}.

%%====================================================================
%% Erlang Code
%%====================================================================
Erlang code.
