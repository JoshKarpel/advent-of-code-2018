use std::fs::File;
use std::io::prelude::*;
use std::collections::HashSet;

fn numbers() -> Vec<i64> {
    let mut f = File::open("data/day_01.txt").expect("data not found");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("reading failed");

    contents.split("\n")
        .filter_map(|x| x.parse::<i64>().ok())  // empty lines give an error, which gets turned into a None, which gets ignored
        .collect()
}

fn day_01_part_1() -> i64 {
    numbers().iter().sum()
}

fn day_01_part_2() -> i64 {
    let mut sums = HashSet::new();
    let mut sum = 0;

    for n in numbers().iter().cycle() {
        sum += n;
        if sums.contains(&sum) {
            return sum;
        }
        sums.insert(sum);
    };

    0 // loop is infinite and will never hit this
}


fn main() {
    println!("Part 1: {}", day_01_part_1());
    println!("Part 2: {}", day_01_part_2());
}
