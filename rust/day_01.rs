use std::fs::File;
use std::io::prelude::*;
use std::collections::HashSet;

fn get_numbers() -> Vec<i64> {
    let mut f = File::open("data/day_01.txt").expect("data not found");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("reading failed");

    contents.trim_end()
        .split("\n")
        .map(|x| x.parse::<i64>().unwrap())
        .collect()
}

fn part_1() -> i64 {
    get_numbers().iter().sum()
}

fn part_2() -> i64 {
    let mut sums = HashSet::new();
    let mut sum = 0;

    for n in get_numbers().iter().cycle() {
        sum += n;
        if sums.contains(&sum) {
            return sum;
        }
        sums.insert(sum);
    };

    0 // loop is infinite and will never hit this
}


fn main() {
    println!("Part 1: {}", part_1());
    println!("Part 2: {}", part_2());
}
