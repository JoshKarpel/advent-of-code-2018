from pathlib import Path
import itertools
from dataclasses import dataclass


def get_data():
    return (int(x) for x in Path('data/day_08.txt').read_text().strip().split(' '))


@dataclass(frozen = True)
class Node:
    children: list
    metadata: list

    @property
    def num_children(self):
        return len(self.children)

    @property
    def num_metadata(self):
        return len(self.metadata)


def take(n, iterator):
    for _ in range(n):
        yield next(iterator)


def walk(node):
    yield node
    for child in node.children:
        yield from walk(child)


def build_node(data):
    num_children, num_metadata = take(2, data)

    return Node(
        children = list(build_node(data) for _ in range(num_children)),
        metadata = list(take(num_metadata, data)),
    )


def part_1():
    data = get_data()
    root = build_node(data)

    s = 0
    for node in walk(root):
        s += sum(node.metadata)

    return s


def value(node):
    if node.num_children == 0:
        return sum(node.metadata)

    v = 0
    for entry in node.metadata:
        try:
            v += value(node.children[entry - 1])
        except IndexError:
            pass

    return v


def part_2():
    data = get_data()
    root = build_node(data)

    return value(root)


if __name__ == '__main__':
    print(f'Part 1: {part_1()}')
    print(f'Part 2: {part_2()}')
