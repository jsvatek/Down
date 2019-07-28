//
//  NSAttributedString+Helpers.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

extension NSAttributedString {

    typealias Attributes = [NSAttributedString.Key: Any]

    func prefix(with length: Int) -> NSAttributedString {
        guard length <= self.length else { return self }
        guard length > 0 else { return NSAttributedString() }
        return attributedSubstring(from: NSMakeRange(0, length))
    }
}

// MARK: - Ranges

extension NSAttributedString {

    var wholeRange: NSRange {
        NSRange(location: 0, length: length)
    }

    func ranges(of name: NSAttributedString.Key) -> [NSRange] {
        var ranges = [NSRange]()
        enumerateAttribute(name, in: wholeRange, options: []) { value, range, _ in
            if value != nil {
                ranges.append(range)
            }
        }

        return ranges
    }

    func paragraphRangesExcludingLists() -> [NSRange] {
        let listRanges = ranges(of: .listMarker)
        let areDisjoint = { (a: NSRange, b: NSRange) in a.intersection(b) == .none }
        let isNotInList = { (range: NSRange) in listRanges.allSatisfy { areDisjoint($0, range) } }
        return paragraphRanges().filter(isNotInList)
    }

    func paragraphRanges() -> [NSRange] {
        guard length > 0 else { return [] }

        func nextParagraphRange(at location: Int) -> NSRange {
            return NSString(string: string).paragraphRange(for: NSRange(location: location, length: 1))
        }

        var result = [nextParagraphRange(at: 0)]

        while let currentLocation = result.last?.upperBound, currentLocation < length {
            result.append(nextParagraphRange(at: currentLocation))
        }

        return result.filter { $0.length > 1 }
    }
}