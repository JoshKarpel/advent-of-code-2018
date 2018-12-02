use std::fs::File;
use std::io::prelude::*;
use std::collections::{HashMap, HashSet};

fn get_ids() -> Vec<String> {
    let mut f = File::open("data/day_02.txt").expect("data not found");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("reading failed");

    contents.trim_end()
        .lines()
        .map(|s| s.to_owned())
        .collect()
}

fn count_chars(s: &str) -> HashMap<char, u32> {
    let mut counter = HashMap::new();
    s.chars()
        .for_each(
            |char| {
                let entry = counter.entry(char).or_insert(0);
                *entry += 1;
            }
        );
    counter
}

fn part_1() -> u32 {
    let mut exactly_two = 0;
    let mut exactly_three = 0;
    get_ids().iter().for_each(|id| {
        let mut counter = count_chars(&id);
        let set: HashSet<u32> = counter
            .drain()
            .map(|(_, v)| v)
            .collect();
        if set.contains(&2) {
            exactly_two += 1;
        }
        if set.contains(&3) {
            exactly_three += 1;
        }
    });

    exactly_two * exactly_three
}

//fn part_2() -> i64 {
//    let mut sums = HashSet::new();
//    let mut sum = 0;
//
//    for n in get_ids().iter().cycle() {
//        sum += n;
//        if sums.contains(&sum) {
//            return sum;
//        }
//        sums.insert(sum);
//    };
//
//    0 // loop is infinite and will never hit this
//}


fn main() {
    println!("Part 1: {}", part_1());
//    println!("Part 2: {}", part_2());
}
