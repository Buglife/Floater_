//
//  FingertipView.swift
//

import UIKit

private let kFingertipSize = CGSize(width: 42, height: 42)

// Number of points that the fingertip view "hovers" above the screen
private let kDefaultTouchHoverAmount: CGFloat = 4

class FingertipView: UIView {
    let surfaceView = SurfaceView()
    let shadowView = ShadowView()
    var fingertipConstraintY: NSLayoutConstraint?
    var shadowConstraintX: NSLayoutConstraint?
    var needsConstraints = true
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clearColor()
        
        shadowView.backgroundColor = .clearColor()
        shadowView.alpha = 0.3
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shadowView)
        
        surfaceView.backgroundColor = .clearColor()
        surfaceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(surfaceView)

        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Auto Layout
    
    override func intrinsicContentSize() -> CGSize {
        return kFingertipSize
    }
    
    override func updateConstraints() {
        if needsConstraints {
            // Fingertip constraints
            let fingertipWidth = NSLayoutConstraint(item: surfaceView, attribute: .Width, toItem: self)
            let fingertipHeight = NSLayoutConstraint(item: surfaceView, attribute: .Height, toItem: self)
            let fingertipX = NSLayoutConstraint(item: surfaceView, attribute: .CenterX, toItem: self)
            let fingertipY = NSLayoutConstraint(item: surfaceView, attribute: .CenterY, toItem: self)
            addConstraints([fingertipWidth, fingertipHeight, fingertipX, fingertipY])

            // Shadow constraints
            let shadowSizeMultiplier: CGFloat = 1.1
            
            let shadowWidthConstraint = NSLayoutConstraint(item: shadowView, attribute: .Width, toItem: self, multiplier: shadowSizeMultiplier)
            let shadowHeightConstraint = NSLayoutConstraint(item: shadowView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: shadowSizeMultiplier, constant: 1)
            
            let shadowConstraintX = NSLayoutConstraint(item: shadowView, attribute: .CenterX, toItem: self)
            let shadowConstraintY = NSLayoutConstraint(item: shadowView, attribute: .CenterY, toItem: self)
            addConstraints([shadowWidthConstraint, shadowHeightConstraint, shadowConstraintX, shadowConstraintY])
            
            self.fingertipConstraintY = fingertipY
            self.shadowConstraintX = shadowConstraintX
            
            needsConstraints = false
        }

        super.updateConstraints()
    }
    
    // MARK: Public methods
    
    func setTouchIsHovering(hovering: Bool) {
        let amount = hovering ? kDefaultTouchHoverAmount : 0
        setTouchHoverAmount(amount)
    }
    
    private func setTouchHoverAmount(touchHoverAmount: CGFloat) {
        fingertipConstraintY?.constant = -touchHoverAmount
        shadowConstraintX?.constant = touchHoverAmount
    }
    
    // MARK: Internal subview classes
    
    class SurfaceView: UIView {
        let strokeWidth: CGFloat = 1

        override func drawRect(rect: CGRect) {
            let ovalRect = CGRectInset(rect, strokeWidth, strokeWidth)
            let ovalPath = UIBezierPath(ovalInRect: ovalRect)
            let fillColor = UIColor(white: 0.75, alpha: 0.80)
            let strokeColor = UIColor(white: 0.65, alpha: 1)
            ovalPath.lineWidth = strokeWidth
            fillColor.setFill()
            strokeColor.setStroke()
            ovalPath.fill()
            ovalPath.stroke()
        }
    }
}

private extension NSLayoutConstraint {
    convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, toItem view2: AnyObject?, multiplier: CGFloat = 1) {
        self.init(item: view1, attribute: attr1, relatedBy: .Equal, toItem: view2, attribute: attr1, multiplier: multiplier, constant: 0)
    }
}
