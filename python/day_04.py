from pathlib import Path
from dataclasses import dataclass, replace
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
    cleaned_records = []
    for r in records:
        if r.guard is not None:
            most_recent_guard = r.guard
        else:
            cleaned_records.append(replace(r, guard = most_recent_guard))

    sleeping = []
    it = iter(cleaned_records)
    for fall_asleep in it:
        wake_up = next(it)
        sleeping.append((fall_asleep.guard, fall_asleep.minute, wake_up.minute))

    sleeping_by_guard = collections.defaultdict(lambda: collections.defaultdict(int))
    for guard, fall_asleep, wake_up in sleeping:
        for minute in range(fall_asleep, wake_up + 1):
            sleeping_by_guard[guard][minute] += 1

    most_sleeping = max(sleeping_by_guard.items(), key = lambda x: sum(x[1].values()))
    most_slept_minute = max(most_sleeping[1].items(), key = lambda x: x[1])
    return most_sleeping[0] * most_slept_minute[0]


def part_2():
    pass


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
