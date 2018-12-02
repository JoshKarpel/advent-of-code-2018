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
  part_2(numbers(), 0, sets:new()).

part_2([], Sum, Sums) ->
  part_2(numbers(), Sum, Sums);
part_2(Changes, Sum, Sums) ->
  [Head | Tail] = Changes,
  NewSum = Sum + Head,
  case sets:is_element(NewSum, Sums) of
    true -> NewSum;
    false ->
      NewSums = sets:add_element(Sum, Sums),
      part_2(Tail, NewSum, NewSums)
  end.

print_list(List) -> [io:format("~p ", [X]) || X <- List].
