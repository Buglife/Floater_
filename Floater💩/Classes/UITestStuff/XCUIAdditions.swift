//
//  XCUIAdditions.swift
//

import XCTest

public extension XCUIElement {
    // MARK: Public methods
    
    // Moves the fingertip to the receiver's location
    @objc(float_)
    func float💩() {
        visual_centerCoordinate.float💩()
    }
    
    // MARK: Private methods
    
    private var visual_centerCoordinate: XCUICoordinate {
        get {
            let normalizedOffset = CGVector(dx: 0.5, dy: 0.5) // should tap right in the center of the element
            let coordinate = coordinateWithNormalizedOffset(normalizedOffset)
            return coordinate
        }
    }
}

public extension XCUICoordinate {
    // MARK: Public methods

    // Moves the fingertip to the receiver's location
    @objc(float_)
    func float💩() {
        let moveDuration = Fingertip.defaultFingertip.moveToPoint(screenPoint)
        floater_wait(moveDuration)
    }
    
    // MARK: Private methods
    
    private func floater_wait(duration: NSTimeInterval) {
        NSThread.sleepForTimeInterval(duration)
    }
}
