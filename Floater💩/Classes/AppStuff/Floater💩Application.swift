//
//  Floater💩Application.swift
//

import UIKit

// This class *should* be named `Floater💩Application`,
// with its @objc name as `FLTRApplication`. Unfortunately, Swift 2.2
// has a bug that prevents Objective-C from importing headers
// with emoji in the SWIFT_NAME attribute. So for now we have a typealias,
// which is strongly preferred if you're using Swift in your app since
// you should be using the emoji variant of the name.
// I mean what are we, animals?
public typealias Floater💩Application = FLTRApplication

// This class will be renamed to `Floater💩Application`
// in a future release.
public class FLTRApplication: UIApplication {
    private let floater💩Window = Floater💩Window()

    public override init() {
        super.init()
        floater💩Window.prepare()
    }
    
    override public func sendEvent(event: UIEvent) {
        floater💩Window.sendEvent(event)
        super.sendEvent(event)
    }
}
