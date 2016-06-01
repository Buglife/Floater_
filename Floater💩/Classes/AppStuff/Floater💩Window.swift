//
//  Floater💩Window.swift
//

import UIKit
import HSTestingBackchannel

// Overlay window that contains the fingertip view.
class Floater💩Window: UIWindow {
    // MARK: Stored properties

    let fingertipView = FingertipView()
    var centerConstraintX: NSLayoutConstraint?
    var centerConstraintY: NSLayoutConstraint?
    var needsConstraints = true // Ugh, there's gotta be a better way to ensure constraints only get installed once in updateConstraints :-/
    
    // MARK: Initialization
    
    public init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        // Window configuration
        windowLevel = UIWindowLevelAlert + 100
        rootViewController = UIViewController()
        userInteractionEnabled = false
        
        // Set up subviews
        fingertipView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fingertipView)
        setNeedsUpdateConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public func prepare() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("applicationDidFinishLaunching:"), name: UIApplicationDidFinishLaunchingNotification, object: nil)
    }
    
    // MARK: UIView overrides
    
    override public func sendEvent(event: UIEvent) {
        if event.type == .Touches, let touches = event.allTouches() {
            let didTouchDown = touches.contains { $0.phase == .Began }
            let didTouchUp = touches.contains { $0.phase == .Ended || $0.phase == .Cancelled }
            
            // Yep, only support for 1 touch at a time right now
            if didTouchDown {
                setTouchIsHovering(false, animated: false)
            } else if didTouchUp {
                setTouchIsHovering(true, animated: true)
            }
        }
        
        super.sendEvent(event)
    }
    
    override public func updateConstraints() {
        if needsConstraints {
            let centerConstraintX = NSLayoutConstraint(item: fingertipView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 140)
            let centerConstraintY = NSLayoutConstraint(item: fingertipView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 288)

            addConstraints([centerConstraintX, centerConstraintY])

            self.centerConstraintX = centerConstraintX
            self.centerConstraintY = centerConstraintY

            setTouchIsHovering(true, animated: false)
            
            needsConstraints = false
        }

        super.updateConstraints()
    }
    
    // MARK: Touch view manipulation
    
    func setTouchOffset(touchOffset: CGPoint) {
        let fingertipSize = fingertipView.intrinsicContentSize()
        centerConstraintX?.constant = touchOffset.x - (fingertipSize.width / 2)
        centerConstraintY?.constant = touchOffset.y - (fingertipSize.height / 2)
    }
    
    func setTouchIsHovering(hovering: Bool, animated: Bool) {
        fingertipView.setTouchIsHovering(hovering)
        
        if animated {
            animateLayoutWithDuration(0.1)
        } else {
            layoutIfNeeded()
        }
    }
    
    // Helper method for animating layout changes
    private func animateLayoutWithDuration(duration: NSTimeInterval, delay: NSTimeInterval = 0, options: UIViewAnimationOptions? = nil, completion: ((Bool) -> Void)? = nil) {
        let options = options ?? []
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: { 
            self.layoutIfNeeded()
        }, completion: completion)
    }
    
    // MARK: Notifications
    
    func applicationDidFinishLaunching(notification: NSNotification) {
        install()
    }
    
    func shouldMoveNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            assertionFailure("Received notification with nil userInfo")
            return
        }

        let screenPoint = userInfo.CGPointForKey(Constants.NotificationUserInfo.screenPoint)
        let moveDuration = userInfo.doubleValueForKey(Constants.NotificationUserInfo.moveDuration) ?? 0
        let moveDelay = userInfo.doubleValueForKey(Constants.NotificationUserInfo.moveDelay) ?? 0
        let options = userInfo.animationOptionsForKey(Constants.NotificationUserInfo.animationOptions) ?? UIViewAnimationOptions.CurveEaseInOut
        
        setTouchOffset(screenPoint)
        animateLayoutWithDuration(moveDuration, delay: moveDelay, options: options)
    }
    
    // MARK: Private methods
    
    private func install() {
        // Configure bridge
        HSTestingBackchannel.installReceiver()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Floater💩Window.shouldMoveNotification), name: Constants.ShouldMoveNotification, object: nil)
        
        // Make window visible
        hidden = false
    }
}

let kNumberFormatter = NSNumberFormatter()

// Helper methods for extracting objects from notification payloads.
// IIRC theres houldn't be any category collisions since Swift should
// keep this extension private
private extension Dictionary where Key: NSObject, Value: AnyObject {
    func numberForKey(key: Key) -> NSNumber? {
        guard let numberString = stringForKey(key) else {
            return nil
        }
        
        return kNumberFormatter.numberFromString(numberString)
    }
    
    func stringForKey(key: Key) -> String? {
        return self[key] as? String
    }
    
    func doubleValueForKey(key: Key) -> Double? {
        return numberForKey(key)?.doubleValue
    }
    
    func CGPointForKey(key: Key) -> CGPoint {
        guard let pointString = stringForKey(key) else {
            return CGPointFromString("")
        }
        
        return CGPointFromString(pointString)
    }

    func animationOptionsForKey(key: Key) -> UIViewAnimationOptions? {
        guard let animationOptionsNumber = numberForKey(key) else {
            return nil
        }

        return UIViewAnimationOptions(rawValue: animationOptionsNumber.unsignedIntegerValue)
    }
}
