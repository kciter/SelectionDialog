//
//  KCSelectionDialog.swift
//  Sample
//
//  Created by LeeSunhyoup on 2015. 9. 28..
//  Copyright © 2015년 KCSelectionView. All rights reserved.
//

import UIKit

public class KCSelectionDialog: UIView {
    public var items: [KCSelectionDialogItem] = []
    
    public var titleHeight: CGFloat = 50
    public var buttonHeight: CGFloat = 50
    public var cornerRadius: CGFloat = 7
    public var itemPadding: CGFloat = 10
    
    public var useMotionEffects: Bool = true
    public var motionEffectExtent: Int = 10
    
    public var title: String? = "Title"
    public var closeButtonTitle: String? = "Close"
    public var closeButtonColor: UIColor?
    public var closeButtonColorHighlighted: UIColor?
    
    private var dialogView: UIView?
    
    public init() {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        setObservers()
    }
    
    public init(title: String, closeButtonTitle cancelString: String) {
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
        dialogView = createDialogView()
        guard let dialogView = dialogView else { return }
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        
        dialogView.layer.opacity = 0.5
        dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        self.addSubview(dialogView)
        
        self.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            dialogView.layer.opacity = 1
            dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }, completion: nil)
    }
    
    public func close() {
        guard let dialogView = dialogView else { return }
        let currentTransform = dialogView.layer.transform
        
        dialogView.layer.opacity = 1
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.backgroundColor = UIColor(white: 0, alpha: 0)
            dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
            dialogView.layer.opacity = 0
            }, completion: { (finished: Bool) in
                for view in self.subviews {
                    view.removeFromSuperview()
                }
                
                self.removeFromSuperview()
        })
    }
    
    public func addItem(item itemTitle: String) {
        let item = KCSelectionDialogItem(item: itemTitle)
        items.append(item)
    }
    
    public func addItem(item itemTitle: String, icon: UIImage) {
        let item = KCSelectionDialogItem(item: itemTitle, icon: icon)
        items.append(item)
    }
    
    public func addItem(item itemTitle: String, didTapHandler: (() -> Void)) {
        let item = KCSelectionDialogItem(item: itemTitle, didTapHandler: didTapHandler)
        items.append(item)
    }
    
    public func addItem(item itemTitle: String, icon: UIImage, didTapHandler: (() -> Void)) {
        let item = KCSelectionDialogItem(item: itemTitle, icon: icon, didTapHandler: didTapHandler)
        items.append(item)
    }
    
    public func addItem(item: KCSelectionDialogItem) {
        items.append(item)
    }
    
    private func setObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceOrientationDidChange:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    private func createDialogView() -> UIView {
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
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.blackColor().CGColor
        
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        if useMotionEffects {
            applyMotionEffects(view)
        }
        
        view.addSubview(createTitleLabel())
        view.addSubview(createContainerView())
        view.addSubview(createCloseButton())
        
        return view
    }
    
    private func createContainerView() -> UIView {
        let containerView = UIView(frame: CGRectMake(0, titleHeight, 300, CGFloat(items.count*50)))
        for (index, item) in items.enumerate() {
            let itemButton = UIButton(frame: CGRectMake(0, CGFloat(index*50), 300, 50))
            let itemTitleLabel = UILabel(frame: CGRectMake(itemPadding, 0, 255, 50))
            itemTitleLabel.text = item.itemTitle
            itemTitleLabel.textColor = UIColor.blackColor()
            itemButton.addSubview(itemTitleLabel)
            itemButton.setBackgroundImage(UIImage.createImageWithColor(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)), forState: .Highlighted)
            itemButton.addTarget(item, action: "handlerTap", forControlEvents: .TouchUpInside)
            
            if item.icon != nil {
                itemTitleLabel.frame.origin.x = 34 + itemPadding*2
                let itemIcon = UIImageView(frame: CGRectMake(itemPadding, 8, 34, 34))
                itemIcon.image = item.icon
                itemButton.addSubview(itemIcon)
            }
            containerView.addSubview(itemButton)
            
            let divider = UIView(frame: CGRectMake(0, CGFloat(index*50)+50, 300, 0.5))
            divider.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            containerView.addSubview(divider)
            containerView.frame.size.height += 50
        }
        return containerView
    }
    
    private func createTitleLabel() -> UIView {
        let view = UILabel(frame: CGRectMake(0, 0, 300, titleHeight))
        
        view.text = title
        view.textAlignment = .Center
        view.font = UIFont.boldSystemFontOfSize(18.0)
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRectMake(0, view.bounds.size.height, view.bounds.size.width, 0.5)
        bottomLayer.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).CGColor
        view.layer.addSublayer(bottomLayer)
        
        return view
    }
    
    private func createCloseButton() -> UIButton {
        let button = UIButton(frame: CGRectMake(0, titleHeight + CGFloat(items.count*50), 300, buttonHeight))
        
        button.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        
        let colorNormal = closeButtonColor != nil ? closeButtonColor : button.tintColor
        let colorHighlighted = closeButtonColorHighlighted != nil ? closeButtonColorHighlighted : colorNormal?.colorWithAlphaComponent(0.5)
        
        button.setTitle(closeButtonTitle, forState: UIControlState.Normal)
        button.setTitleColor(colorNormal, forState: UIControlState.Normal)
        button.setTitleColor(colorHighlighted, forState: UIControlState.Highlighted)
        button.setTitleColor(colorHighlighted, forState: UIControlState.Disabled)
        
        let topLayer = CALayer()
        topLayer.frame = CGRectMake(0, 0, 300, 0.5)
        topLayer.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).CGColor
        button.layer.addSublayer(topLayer)
        
        return button
    }
    
    private func calculateDialogSize() -> CGSize {
        return CGSizeMake(300, CGFloat(items.count)*50.0 + titleHeight + buttonHeight)
    }
    
    private func calculateScreenSize() -> CGSize {
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        return CGSizeMake(width, height)
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
    
    internal func deviceOrientationDidChange(notification: NSNotification) {
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        let screenSize = self.calculateScreenSize()
        let dialogSize = self.calculateDialogSize()
        
        dialogView?.frame = CGRectMake(
            (screenSize.width - dialogSize.width) / 2,
            (screenSize.height - dialogSize.height) / 2,
            dialogSize.width,
            dialogSize.height
            )
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
}
