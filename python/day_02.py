from pathlib import Path
from collections import Counter


def get_ids():
    yield from Path('data/day_02.txt').read_text().strip().split()


def day_02_part_1():
    exactly_two = 0
    exactly_three = 0
    for id in get_ids():
        counter = Counter(id)
        if 2 in counter.values():
            exactly_two += 1
        if 3 in counter.values():
            exactly_three += 1

    return exactly_two * exactly_three


def day_02_part_2():
    ids = list(get_ids())
    length = len(ids[0])
    for position in range(length):
        sliced_ids = (x[:position] + x[position + 1:] for x in ids)
        reverse_counter = {v: k for k, v in Counter(sliced_ids).items()}
        try:
            return reverse_counter[2]  # there can only be one pair that differ by one character (or none, in which case try again)
        except KeyError:
            pass


if __name__ == '__main__':
    print(f'Part 1: {day_02_part_1()}')
    print(f'Part 2: {day_02_part_2()}')
