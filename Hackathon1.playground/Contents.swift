//: Playground - noun: a place where people can play

import UIKit

func medium(ranges: [CountableClosedRange<Int>]) -> Int {
    var min = 0
    var max = 0
    ranges.forEach {
        if min > $0.lowerBound {
            min = $0.lowerBound
        }
        if max < $0.upperBound {
            max = $0.upperBound
        }
    }
    print("max: \(max) min: \(min)")
    return Int(ceil(((Float(max)-Float(min))/2)+Float(min)))
}

func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        } else {
            return midIndex
        }
    }
}

func closest(value: Int, from range: CountableClosedRange<Int>) -> Int {
    let pick: Int
    if value < range.lowerBound {
        pick = range.lowerBound
    } else if value > range.upperBound {
        pick = range.upperBound
    } else {
        pick = value
    }
    return pick
}

func minimumSum(ranges: [CountableClosedRange<Int>]) -> Int {
    let mediumValue = medium(ranges: ranges)
    print("mediumValue: \(mediumValue)")
    var sum = 0
    var prevValue: Int?
    for (index, range) in ranges.enumerated() {
        var pick: Int
        if let prevValue = prevValue {
            pick = closest(value: prevValue, from: range)
            sum += abs(prevValue - pick)
            print("prevValue: \(prevValue) pick: \(pick)")
        } else {
            pick = closest(value: mediumValue, from: range)
            if ranges.count > index + 1 {
                let nextRange = ranges[index+1]
                if !nextRange.contains(pick) {
                    if range.upperBound < nextRange.lowerBound {
                        pick = range.upperBound
                    } else {
                        pick = range.lowerBound
                    }
                } else {
                    pick = closest(value: pick, from: nextRange)
                }
            }
            print("first pick: \(pick)")
        }
        print("sum: \(sum)")
        prevValue = pick
    }
    return sum
}

let rangesArray: [[CountableClosedRange<Int>]] = [[1...3, 3...7, (-2)...0],
                   [1...3, 3...7, (-2)...0, 4...8, 8...12],
                   [1...3, 1...3, 4...8, 1...3, 1...3, 4...8],
                   [1...3, 1...4, 4...7],
                   [(-10)...(-4), (-20)...(-11), (-2)...(-1)],
                   [1...300, 1150...2000, 4...8, 1...3, 1...3, 4...8],
                   [1...300, 100...200, 4...8, 1...3, 1...3, 4...8],
                   [1...2, 2...6, 6...10, 11...12, 12...29, 29...40],
                   [1...12, 2...6, (-10)...10, (-4)...12, 26...29, (-12)...40],
                   [1...300, 301...302, 304...400],
                   [1...100, 20...40, 30...50, 20...50, 21...25, 42...80, 20...80, 30...51]
                ]

rangesArray.forEach {
    print("============")
    print("ranges: (\($0.map { "\($0.lowerBound...$0.upperBound)" })")
    let number = minimumSum(ranges: $0)
    print("minimumSum: (\(number))")
    print("============")
}

