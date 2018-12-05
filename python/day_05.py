from pathlib import Path
import itertools


def get_polymer():
    return Path('data/day_05.txt').read_text().strip()


def unit_pairs(units):
    for unit in units:
        yield f'{unit}{unit.upper()}'
        yield f'{unit.upper()}{unit}'


def part_1():
    poly = get_polymer()

    units = set(x.lower() for x in poly)
    pairs = list(unit_pairs(units))
    previous_len = None
    while len(poly) != previous_len:
        previous_len = len(poly)
        for unit_pair in pairs:
            poly = poly.replace(unit_pair, '')

    return len(poly)


def part_2():
    pass


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
