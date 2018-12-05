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
    original_poly = get_polymer()

    removed_unit_to_len = {}

    units = set(x.lower() for x in original_poly)
    pairs = list(unit_pairs(units))
    for removed_unit in units:
        poly = original_poly.replace(removed_unit, '').replace(removed_unit.upper(), '')

        previous_len = None
        while len(poly) != previous_len:
            previous_len = len(poly)
            for unit_pair in pairs:
                poly = poly.replace(unit_pair, '')

        removed_unit_to_len[removed_unit] = len(poly)

    return min(removed_unit_to_len.values())


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
