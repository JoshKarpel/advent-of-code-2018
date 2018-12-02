from pathlib import Path
import itertools


def get_numbers():
    yield from (int(x) for x in Path('data/day_01.txt').read_text().strip().split())


def part_1():
    return sum(get_numbers())


def part_2():
    sums = set()
    sum = 0
    for n in itertools.cycle(get_numbers()):
        sum += n
        if sum in sums:
            return sum
        sums.add(sum)


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
