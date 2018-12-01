from pathlib import Path
import itertools


def numbers():
    yield from (int(x) for x in Path('data/day_01.txt').read_text().split())


def day_01_part_1():
    return sum(numbers())


def day_01_part_2():
    sums = set()
    sum = 0
    for n in itertools.cycle(numbers()):
        sum += n
        if sum in sums:
            return sum
        sums.add(sum)


if __name__ == '__main__':
    print(f'Part 1: {day_01_part_1()}')
    print(f'Part 2: {day_01_part_2()}')
