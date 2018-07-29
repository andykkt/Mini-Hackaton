//: Playground - noun: a place where people can play

import UIKit

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

func getsum(value: Int, ranges: [CountableClosedRange<Int>]) -> Int {
    var sum = 0
    var prevValue: Int?
    for (index, range) in ranges.enumerated() {
        var pick: Int
        if let prevValue = prevValue {
            pick = closest(value: prevValue, from: range)
            sum += abs(prevValue - pick)
        } else {
            pick = closest(value: value, from: range)
            if ranges.count > index + 1 {
                let nextRange = ranges[index+1]
                if !nextRange.contains(pick) {
                    let nextClosest = closest(value: pick, from: nextRange)
                    pick = closest(value: nextClosest, from: range)
                }
            }
        }
        prevValue = pick
    }
    return sum
}

func minimumSum(ranges: [CountableClosedRange<Int>]) -> Int {
    let range = ranges[0]
    var minimumSum = Int.max
    for (_, value) in range.enumerated() {
        let sum = getsum(value: value, ranges: ranges)
        if minimumSum > sum {
            minimumSum = sum
        }
    }
    return minimumSum
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
                   [1...100, 20...40, 30...50, 20...50, 21...25, 42...80, 20...80, 30...51],
                   [1...300, 1...200, 200...300],
                   [(-300)...(-1), (-202)...(-21), (-300)...(-200)]
                ]

rangesArray.forEach {
    print("============")
    print("ranges: (\($0.map { "\($0.lowerBound...$0.upperBound)" }.joined(separator: ", " )))")
    let number = minimumSum(ranges: $0)
    print("minimumSum: (\(number))")
    print("============")
}

