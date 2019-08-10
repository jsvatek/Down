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

    func ranges(of key: Key) -> [NSRange] {
        ranges(of: key, in: wholeRange)
    }

    func ranges(of key: Key, in range: NSRange) -> [NSRange] {
        var ranges = [NSRange]()

        enumerateAttribute(key, in: range, options: []) { value, range, _ in
            if value != nil {
                ranges.append(range)
            }
        }

        return ranges
    }

    func rangesMissingAttribute(for key: Key) -> [NSRange] {
        rangesMissingAttribute(for: key, in: wholeRange)
    }

    func rangesMissingAttribute(for key: Key, in range: NSRange) -> [NSRange] {
        var ranges = [NSRange]()

        enumerateAttribute(key, in: range, options: []) { value, attrRange, _ in
            if value == nil {
                ranges.append(attrRange)
            }
        }

        return ranges
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

    func enumerateAttributes<A>(for key: Key, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerateAttributes(for: key, in: wholeRange, block: block)
    }

    func enumerateAttributes<A>(for key: Key, in range: NSRange, block: (_ attr: A, _ range: NSRange) -> Void) {
        enumerateAttribute(key, in: range, options: []) { value, range, _ in
            if let value = value as? A {
                block(value, range)
            }
        }
    }
}