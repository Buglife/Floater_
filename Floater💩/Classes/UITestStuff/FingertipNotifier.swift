//
//  FingertipNotifier.swift
//

import HSTestingBackchannel

class FingertipNotifier {
    // MARK: Initialization
    
    // Yeah, yeah... singletons are evil. And yes, we'll probably
    // need to support multiple fingertips at some point. That's
    // what TODO's are for, right? :P
    static let sharedNotifier = FingertipNotifier()

    // MARK: Properties

    func sendNotification(notification: String, point: CGPoint? = nil, duration: NSTimeInterval? = nil, delay: NSTimeInterval? = nil) {
        var userInfo: [NSObject : AnyObject] = [:]
        
        if let point = point {
            let pointString = NSStringFromCGPoint(point)
            userInfo[Constants.NotificationUserInfo.screenPoint] = pointString
        }
        
        if let duration = duration {
            userInfo[Constants.NotificationUserInfo.moveDuration] = "\(duration)"
        }
        
        if let delay = delay {
            userInfo[Constants.NotificationUserInfo.moveDelay] = "\(delay)"
        }
        
        HSTestingBackchannel.sendNotification(notification, withDictionary: userInfo)
    }
}
