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

func pickValue(range: CountableClosedRange<Int>, medium: Int, prevValue: Int?) -> Int {
    var pick: Int
    if let prevValue = prevValue {
        if prevValue < range.lowerBound {
            pick = range.lowerBound
        } else if prevValue > range.upperBound {
            pick = range.upperBound
        } else {
            pick = prevValue
        }
    } else {
        if range.lowerBound > medium {
            pick = range.lowerBound
        } else if range.upperBound < medium {
            pick = range.upperBound
        } else {
            pick = medium
        }
    }
    return pick
}

func minimumSum(ranges: [CountableClosedRange<Int>]) -> Int {
    let mediumValue = medium(ranges: ranges)
    print("mediumValue: \(mediumValue)")
    var sum = 0
    var prevValue: Int?
    ranges.forEach {
        let pick = pickValue(range: $0, medium: mediumValue, prevValue: prevValue)
        if let prevValue = prevValue {
            sum += abs(prevValue - pick)
            print("prevValue: \(prevValue) pick: \(pick)")
        } else {
            prevValue = pick
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
                   [1...12, 2...6, (-10)...10, (-4)...12, 26...29, (-12)...40]
                ]

rangesArray.forEach {
    print("============")
    print("ranges (\($0)")
    let number = minimumSum(ranges: $0)
    print("minimumSum: (\(number))")
    print("============")
}

