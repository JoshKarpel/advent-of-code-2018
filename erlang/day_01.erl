#!/usr/bin/env escript

-module(day_01).

main(_) ->
  io:fwrite("Part 1: ~p~n", [part_1()]),
  io:fwrite("Part 2: ~p~n", [part_2()]).

numbers() ->
  {ok, Device} = file:open("data/day_01.txt", [read]),
  numbers(Device, []).

numbers(Device, Acc) ->
  case io:fread(Device, "", "~d") of
    {ok, [X]} ->
      numbers(Device, [X | Acc]);
    eof ->
      lists:reverse(Acc)
  end.

part_1() -> lists:sum(numbers()).

part_2() ->
  part_2([], 0, sets:new(), numbers()).

part_2([], Sum, Sums, Numbers) ->
  part_2(Numbers, Sum, Sums, Numbers);
part_2(Changes, Sum, Sums, Numbers) ->
  [Head | Tail] = Changes,
  NewSum = Sum + Head,
  case sets:is_element(NewSum, Sums) of
    true -> NewSum;
    false ->
      NewSums = sets:add_element(Sum, Sums),
      part_2(Tail, NewSum, NewSums, Numbers)
  end.

print_list(List) -> [io:format("~p ", [X]) || X <- List].
