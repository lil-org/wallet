// Copyright © 2022 Tokenary. All rights reserved.

import SwiftUI
#if canImport(UIKit)
    import UIKit
    typealias BridgedImage = UIImage
#elseif canImport(AppKit) && !targetEnvironment(macCatalyst)
    import AppKit
    typealias BridgedImage = NSImage
#endif

extension Image {
    init(packageResource name: String, ofType type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type),
              let image = BridgedImage(contentsOfFile: path) else {
            self.init(name)
            return
        }
#if canImport(UIKit)
        self.init(uiImage: image)
#elseif canImport(AppKit)
        self.init(nsImage: image)
#endif
    }
    
    init(_ name: String, defaultImage: String) {
        guard let img = BridgedImage(named: name) else {
            self.init(defaultImage)
            return
        }
#if canImport(UIKit)
        self.init(uiImage: img)
#elseif canImport(AppKit)
        self.init(nsImage: img)
#endif
    }
        
    init(_ name: String, defaultSystemImage: String) {

        if let img = BridgedImage(named: name) {
#if canImport(UIKit)
            self.init(uiImage: img)
#elseif canImport(AppKit)
            self.init(nsImage: img)
#endif
            return
        }

        self.init(systemName: defaultSystemImage)
    }

    init(_ image: BridgedImage?, defaultImage: String) {
        if let image = image {
#if canImport(UIKit)
            self.init(uiImage: image)
#elseif canImport(AppKit)
            self.init(nsImage: image)
#endif
        } else {
            self.init(defaultImage)
        }
    }
}
