#!/usr/bin/env escript

main(_) ->
    One = 1,
    Point = {5, 7},
    {X, Y} = Point,
    io:format("One is ~p ~n", [One]),
    io:format("Point is ~p ~n", [Point]),
    io:format("X is ~p Y is ~p ~n", [X, Y]),
    io:format("Atom: ~p ~n", [atom]),
    L1 = [1,2,3],
    L2 = [4,5],
    io:format("List ~p~n", [L1 ++ L2]),
    io:format("Hello World ~n").
