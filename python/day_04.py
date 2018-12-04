from pathlib import Path
from dataclasses import dataclass
import re
import itertools
import collections
import enum

date_regex = re.compile(r'\[(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2})\]')
id_regex = re.compile(r'#(\d+)')


class Event(enum.Enum):
    BEGIN_SHIFT = 0
    FALL_ASLEEP = 1
    WAKE_UP = 2


@dataclass(frozen = True, order = True)
class Record:
    year: int
    month: int
    day: int
    hour: int
    minute: int
    event: Event
    guard: int

    @classmethod
    def from_entry(cls, entry: str):
        date = entry[:18]
        info = entry[19:]

        date_match = date_regex.match(date)
        id_match = None

        if 'begins' in info:
            event = Event.BEGIN_SHIFT
            id_match = id_regex.search(info)
        elif 'wakes' in info:
            event = Event.WAKE_UP
        elif 'asleep' in info:
            event = Event.FALL_ASLEEP
        else:
            raise ValueError('unrecognized event')

        return cls(
            *(int(x) for x in date_match.groups()),
            event = event,
            guard = int(id_match.group(1)) if id_match is not None else None,
        )


def get_records():
    yield from (Record.from_entry(x.strip()) for x in Path('data/day_04.txt').read_text().strip().split('\n'))


def part_1():
    records = sorted(get_records())
    for r in records:
        print(r)


def part_2():
    pass


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
