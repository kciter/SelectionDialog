//
//  KCSelectionDialog.swift
//  Sample
//
//  Created by LeeSunhyoup on 2015. 9. 28..
//  Copyright © 2015년 KCSelectionView. All rights reserved.
//

import UIKit

public class KCSelectionDialog: UIView {
    var items: [KCSelectionDialogItem] = []
    
    var titleHeight: CGFloat = 50
    var buttonHeight: CGFloat = 50
    var cornerRadius: CGFloat = 7
    
    var useMotionEffects: Bool = true
    var motionEffectExtent: Int = 10
    
    var title: String? = "Title"
    var closeButtonTitle: String? = "Close"
    var closeButtonColor: UIColor?
    var closeButtonColorHighlighted: UIColor?
    
    private var dialogView: UIView!
    private var containerView: UIView!
    
    init() {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        setObservers()
    }
    
    init(title: String, closeButtonTitle cancelString: String) {
        self.title = title
        self.closeButtonTitle = cancelString
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        setObservers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setObservers()
    }
    
    public func show() {
        dialogView = createAlertView()
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.addSubview(dialogView)
        
        switch (UIApplication.sharedApplication().statusBarOrientation) {
        case UIInterfaceOrientation.LandscapeLeft:
            self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 270 / 180))
            
        case UIInterfaceOrientation.LandscapeRight:
            self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 90 / 180))
            
        case UIInterfaceOrientation.PortraitUpsideDown:
            self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 180 / 180))
            
        default:
            break
        }
        
        self.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.dialogView.layer.opacity = 1
            self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: nil)
    }
    
    public func close() {
        let currentTransform = dialogView.layer.transform
        
        let startRotation = dialogView.valueForKeyPath("layer.transform.rotation.z")!.floatValue
        let rotation = CATransform3DMakeRotation(CGFloat(-startRotation) + CGFloat(M_PI * 270 / 180), 0, 0, 0)
        
        
        dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        dialogView.layer.opacity = 1
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
            self.dialogView.layer.opacity = 0
            }, completion: { (finished: Bool) in
                for view in self.subviews {
                    view.removeFromSuperview()
                }
                
                self.removeFromSuperview()
        })
    }
    
    public func addItem(item: KCSelectionDialogItem) {
        items.append(item)
    }
    
    private func setObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
    }
    
    private func createAlertView() -> UIView {
        if containerView == nil {
            containerView = UIView(frame: CGRectMake(0, 50, 300, 0))
            for item in items {
                let itemButton = UIButton(frame: CGRectMake(0, containerView.frame.size.height, 300, 50))
                let itemTitleLabel = UILabel(frame: CGRectMake(10, 0, 255, 50))
                itemTitleLabel.text = item.itemTitle
                itemTitleLabel.textColor = UIColor.blackColor()
                itemButton.addSubview(itemTitleLabel)
                itemButton.setBackgroundImage(UIImage.createImageWithColor(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), forState: .Highlighted)
                itemButton.addTarget(item, action: "handlerTap", forControlEvents: .TouchUpInside)
                
                if item.icon != nil {
                    itemTitleLabel.frame.origin.x = 40
                    let itemIcon = UIImageView(frame: CGRectMake(10, 15, 20, 20))
                    itemIcon.image = item.icon
                    itemButton.addSubview(itemIcon)
                }
                containerView.addSubview(itemButton)
                containerView.frame.size.height += 50
            }
        }
        
        let screenSize = self.calculateScreenSize()
        let dialogSize = self.calculateDialogSize()
        
        let view = UIView(frame: CGRectMake(
            (screenSize.width - dialogSize.width) / 2,
            (screenSize.height - dialogSize.height) / 2,
            dialogSize.width,
            dialogSize.height
            ))
        
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = UIColor.whiteColor()
        view.layer.shadowRadius = cornerRadius + 5
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.blackColor().CGColor
        
        view.layer.opacity = 0.5
        view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        if useMotionEffects {
            applyMotionEffects(view)
        }
        
        self.addTitleToView(view)
        view.addSubview(containerView)
        self.addCloseButtonToView(view)
        
        return view
    }
    
    private func addTitleToView(container: UIView) {
        guard let title = title else { return }
        
        let view = UILabel(frame: CGRectMake(
            0, 0,
            container.bounds.size.width,
            titleHeight
            ))
        
        view.text = title
        view.textAlignment = NSTextAlignment.Center
        view.font = UIFont.boldSystemFontOfSize(18.0)
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRectMake(0, view.bounds.size.height, view.bounds.size.width, 0.5)
        bottomLayer.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).CGColor
        view.layer.addSublayer(bottomLayer)
        
        container.addSubview(view)
    }
    
    private func addCloseButtonToView(container: UIView) {
        guard let closeButtonTitle = closeButtonTitle else { return }
        
        let buttonWidth = container.bounds.size.width
        
        let button = UIButton(type: UIButtonType.Custom)
        
        button.frame = CGRectMake(
            0,
            container.bounds.size.height - buttonHeight,
            buttonWidth,
            buttonHeight
        )
        
        button.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        
        let colorNormal = closeButtonColor != nil ? closeButtonColor : button.tintColor
        let colorHighlighted = closeButtonColorHighlighted != nil ? closeButtonColorHighlighted : colorNormal?.colorWithAlphaComponent(0.5)
        
        button.setTitle(closeButtonTitle, forState: UIControlState.Normal)
        button.setTitleColor(colorNormal, forState: UIControlState.Normal)
        button.setTitleColor(colorHighlighted, forState: UIControlState.Highlighted)
        button.setTitleColor(colorHighlighted, forState: UIControlState.Disabled)
        
        let topLayer = CALayer()
        topLayer.frame = CGRectMake(0, 0, containerView.bounds.size.width, 0.5)
        topLayer.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).CGColor
        button.layer.addSublayer(topLayer)
        
        container.addSubview(button)
    }
    
    private func calculateDialogSize() -> CGSize {
        return CGSizeMake(
            containerView.frame.size.width,
            containerView.frame.size.height + titleHeight + buttonHeight
        )
    }
    
    private func calculateScreenSize() -> CGSize {
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        if orientationIsLandscape() {
            return CGSizeMake(height, width)
        } else {
            return CGSizeMake(width, height)
        }
    }
    
    private func applyMotionEffects(view: UIView) {
        let horizontalEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = -motionEffectExtent
        horizontalEffect.maximumRelativeValue = +motionEffectExtent
        
        let verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = -motionEffectExtent
        verticalEffect.maximumRelativeValue = +motionEffectExtent
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalEffect, verticalEffect]
        
        view.addMotionEffect(motionEffectGroup)
    }
    
    private func orientationIsLandscape() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    internal func deviceOrientationDidChange(notification: NSNotification) {
        let interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        let startRotation: Float = self.valueForKeyPath("layer.transform.rotation.z")!.floatValue!
        
        var rotation: CGAffineTransform
        switch (interfaceOrientation) {
        case UIInterfaceOrientation.LandscapeLeft:
            rotation = CGAffineTransformMakeRotation(CGFloat(-startRotation) + CGFloat(M_PI * 270 / 180))
            
            break
            
        case UIInterfaceOrientation.LandscapeRight:
            rotation = CGAffineTransformMakeRotation(CGFloat(-startRotation) + CGFloat(M_PI * 90 / 180))
            break
            
        case UIInterfaceOrientation.PortraitUpsideDown:
            rotation = CGAffineTransformMakeRotation(CGFloat(-startRotation) + CGFloat(M_PI * 180 / 180))
            break
            
        default:
            rotation = CGAffineTransformMakeRotation(CGFloat(-startRotation) + 0)
            break
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.dialogView.transform = rotation
            }, completion: nil)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            let endInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
            if interfaceOrientation != endInterfaceOrientation {
            }
        })
    }
    
    internal func keyboardWillShow(notification: NSNotification) {
        let screenSize = self.calculateScreenSize()
        let dialogSize = self.calculateDialogSize()
        
        var keyboardSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        
        if orientationIsLandscape() {
            keyboardSize = CGSize(width: keyboardSize.height, height: keyboardSize.width)
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.dialogView.frame = CGRectMake((
                screenSize.width - dialogSize.width) / 2,
                (screenSize.height - keyboardSize.height - dialogSize.height) / 2,
                dialogSize.width,
                dialogSize.height
            )
            }, completion: nil)
    }
    
    internal func keyboardWillHide(notification: NSNotification) {
        let screenSize = self.calculateScreenSize()
        let dialogSize = self.calculateDialogSize()
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.dialogView.frame = CGRectMake(
                (screenSize.width - dialogSize.width) / 2,
                (screenSize.height - dialogSize.height) / 2,
                dialogSize.width,
                dialogSize.height
            )
            }, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
}
