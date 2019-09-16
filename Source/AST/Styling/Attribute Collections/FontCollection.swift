//
//  FontCollection.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import UIKit
public typealias DownFont = UIFont

#elseif canImport(AppKit)

import AppKit
public typealias DownFont = NSFont

#endif

public struct FontCollection {

    public var heading1 = DownFont.boldSystemFont(ofSize: 28)
    public var heading2 = DownFont.boldSystemFont(ofSize: 24)
    public var heading3 = DownFont.boldSystemFont(ofSize: 20)
    public var body = DownFont.systemFont(ofSize: 17)
    public var code = DownFont(name: "menlo", size: 17) ?? .systemFont(ofSize: 17)
    public var listItemPrefix = DownFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)
    
    public init(
        heading1: DownFont = .boldSystemFont(ofSize: 28),
        heading2: DownFont = .boldSystemFont(ofSize: 24),
        heading3: DownFont = .boldSystemFont(ofSize: 20),
        body: DownFont = .systemFont(ofSize: 17),
        code: DownFont = DownFont(name: "menlo", size: 17) ?? .systemFont(ofSize: 17),
        listItemPrefix: DownFont = .monospacedDigitSystemFont(ofSize: 17, weight: .regular)
    ) {
        self.heading1 = heading1
        self.heading2 = heading2
        self.heading3 = heading3
        self.body = body
        self.code = code
        self.listItemPrefix = listItemPrefix
    }
}
