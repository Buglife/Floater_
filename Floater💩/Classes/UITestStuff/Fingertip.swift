//
//  Fingertip.swift
//

import Foundation

class Fingertip {
    // Currently only support one fingertip, but this lays
    // the foundation for multiple fingertips
    static let defaultFingertip = Fingertip(location: CGPointZero)
    
    // MARK: Properties
    
    // The current location of the fingertip on the screen.
    // We need to store this in the test process so that
    // we can calculate the expected animation duration + sleep
    private var currentLocation: CGPoint
    
    // MARK: Initialization
    
    init(location: CGPoint) {
        currentLocation = location
    }
    
    // MARK: Public methods
    
    // Moves the fingertip to the given point. If no moveDuration is provided,
    // then it is calculated based on the current location. The resulting moveDuration
    // is returned.
    func moveToPoint(point: CGPoint, moveDuration: NSTimeInterval? = nil) -> NSTimeInterval {
        guard CGPointEqualToPoint(point, currentLocation) == false else {
            return 0
        }
        
        let moveDuration = moveDuration ?? animationDurationForMoveToPoint(point)
        FingertipNotifier.sharedNotifier.sendNotification(Constants.ShouldMoveNotification, point: point, duration: moveDuration)
        currentLocation = point
        return moveDuration
    }
    
    // MARK: Private methods
    
    private func animationDurationForMoveToPoint(newLocation: CGPoint) -> NSTimeInterval {
        let distanceX = newLocation.x - currentLocation.x
        let distanceY = newLocation.y - currentLocation.y
        let distance = sqrt((distanceX * distanceX) + (distanceY * distanceY))
        return NSTimeInterval(distance / 600)
    }
}
