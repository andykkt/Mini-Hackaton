//: Playground - noun: a place where people can play

import UIKit

struct Range {
    let from: Int
    let to: Int
    init(from: Int, to: Int) {
        self.from = from
        self.to = to
    }
}

func minimumSum(ranges: [Range]) -> Int {
    var total = 0
    var range = ranges[0]
    for index in 0..<ranges.count - 1 {
        let gap: Int
        let nextRange = ranges[index + 1]
        if nextRange.from > range.to {
            gap = abs(nextRange.from - range.to)
            range = Range(from: nextRange.from, to: nextRange.from)
        } else if nextRange.to < range.from {
            gap = abs(range.from - nextRange.to)
            range = Range(from: nextRange.to, to: nextRange.to)
        } else {
            gap = 0
            range = Range(from: max(range.from, nextRange.from), to: min(range.to, nextRange.to))
        }
        total += gap
        print("next range: (\(range.from...range.to))")
    }
    return total
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

let ranges = rangesArray.map { $0.map { Range(from: $0.lowerBound, to: $0.upperBound) } }
ranges.forEach {
    print("============")
    print("ranges: (\($0.map { "\($0.from...$0.to)" }.joined(separator: ", " )))")
    let number = minimumSum(ranges: $0)
    print("minimumSum: (\(number))")
}

//rangesArray.forEach {
//    print("============")
//    print("ranges: (\($0.map { "\($0.lowerBound...$0.upperBound)" }.joined(separator: ", " )))")
//    let number = minimumSum(ranges: $0)
//    print("minimumSum: (\(number))")
//}

//func minimumSum(ranges: [CountableClosedRange<Int>]) -> Int {
//    var total = 0
//    var range = ranges[0]
//    for index in 0..<ranges.count - 1 {
//        let gap: Int
//        let nextRange = ranges[index+1]
//        if nextRange.lowerBound > range.upperBound {
//            gap = abs(nextRange.lowerBound - range.upperBound)
//            range = CountableClosedRange(uncheckedBounds: (lower: nextRange.lowerBound, upper:nextRange.lowerBound))
//        } else if nextRange.upperBound < range.lowerBound {
//            gap = abs(range.lowerBound - nextRange.upperBound)
//            range = CountableClosedRange(uncheckedBounds: (lower: nextRange.upperBound, upper:nextRange.upperBound))
//        } else {
//            gap = 0
//            let maxLowbound = max(range.lowerBound, nextRange.lowerBound)
//            let minUpperbound = min(range.upperBound, nextRange.upperBound)
//            range = CountableClosedRange(uncheckedBounds: (lower: maxLowbound, upper:minUpperbound))
//        }
//        total += gap
//        print("next range: (\(range.lowerBound...range.upperBound))")
//    }
//    return total
//}
//
//let rangesArray: [[CountableClosedRange<Int>]] = [[1...3, 3...7, (-2)...0],
//                                                  [1...3, 3...7, (-2)...0, 4...8, 8...12],
//                                                  [1...3, 1...3, 4...8, 1...3, 1...3, 4...8],
//                                                  [1...3, 1...4, 4...7],
//                                                  [(-10)...(-4), (-20)...(-11), (-2)...(-1)],
//                                                  [1...300, 1150...2000, 4...8, 1...3, 1...3, 4...8],
//                                                  [1...300, 100...200, 4...8, 1...3, 1...3, 4...8],
//                                                  [1...2, 2...6, 6...10, 11...12, 12...29, 29...40],
//                                                  [1...12, 2...6, (-10)...10, (-4)...12, 26...29, (-12)...40],
//                                                  [1...300, 301...302, 304...400],
//                                                  [1...100, 20...40, 30...50, 20...50, 21...25, 42...80, 20...80, 30...51],
//                                                  [1...300, 1...200, 200...300],
//                                                  [(-300)...(-1), (-202)...(-21), (-300)...(-200)]
//]
//
//rangesArray.forEach {
//    print("============")
//    print("ranges: (\($0.map { "\($0.lowerBound...$0.upperBound)" }.joined(separator: ", " )))")
//    let number = minimumSum(ranges: $0)
//    print("minimumSum: (\(number))")
//}
