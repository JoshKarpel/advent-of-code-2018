from pathlib import Path
from dataclasses import dataclass
import re
import itertools
import collections

entry_regex = re.compile(r'#(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)')


@dataclass(frozen = True)
class Claim:
    id: int
    left_edge: int
    top_edge: int
    width: int
    height: int

    @property
    def right_edge(self):
        return self.left_edge + self.width

    @property
    def bottom_edge(self):
        return self.top_edge + self.height

    @classmethod
    def from_entry(cls, entry: str):
        return cls(*(int(x) for x in entry_regex.match(entry).groups()))


def get_claims():
    yield from (Claim.from_entry(x.strip()) for x in Path('data/day_03.txt').read_text().strip().split('\n'))


def claimed_positions(claim):
    yield from itertools.product(
        range(claim.left_edge + 1, claim.right_edge + 1),
        range(claim.top_edge + 1, claim.bottom_edge + 1)
    )


def get_counts_by_position(claims):
    counts = collections.defaultdict(int)
    for claim in claims:
        for pos in claimed_positions(claim):
            counts[pos] += 1

    return counts


def part_1():
    claims = list(get_claims())
    counts = get_counts_by_position(claims)

    return sum(c > 1 for c in counts.values())


def part_2():
    claims = list(get_claims())
    counts = get_counts_by_position(claims)

    for claim in claims:
        found = True
        for pos in claimed_positions(claim):
            if counts[pos] > 1:
                found = False
                break
        if found:
            return claim.id


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
