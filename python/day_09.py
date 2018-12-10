import itertools
from tqdm import tqdm


def play(num_players, last_marble):
    players = itertools.cycle(range(num_players))
    scores = [0 for _ in range(num_players)]

    current_player = next(players)
    marbles = [0]
    current_index = 0

    for marble in tqdm(range(1, last_marble + 1)):
        current_player = next(players)

        if marble % 23 == 0:
            remove_index = (current_index - 7) % len(marbles)
            scores[current_player] += marble + marbles.pop(remove_index)
            current_index = remove_index
        else:
            next_index = (current_index + 2) % len(marbles)
            marbles.insert(next_index, marble)
            current_index = next_index

    return max(scores)


def part_1():
    # return play(9, 25)
    # return play(10, 1618)
    return play(411, 71170)


def part_2():
    return play(411, 71170 * 100)


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
