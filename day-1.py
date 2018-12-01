from pathlib import Path
import itertools


def numbers():
    yield from (int(x) for x in Path('day-1.txt').read_text().split())


def day_1_part_1():
    return sum(numbers())


def day_1_part_2():
    sums = set()
    sum = 0
    for n in itertools.cycle(numbers()):
        sum += n
        if sum in sums:
            return sum
        sums.add(sum)


if __name__ == '__main__':
    print(day_1_part_1())
    print(day_1_part_2())
