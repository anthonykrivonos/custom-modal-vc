//
//  CustomModalViewController.swift
//  CustomModalViewController
//
//  Created by Anthony Krivonos on 7/9/18.
//  Copyright © 2018 Anthony Krivonos. All rights reserved.
//

import UIKit
import Foundation

enum CustomModalBackgroundBlurStyle {
    case light
    case dark
    case none
}

/// Launches a card-like pop-up modal view controller.
class CustomModalViewController: UIViewController {
    
    /// View containing inner view (used for card-like appearance)
    var contentView:UIView!
    
    // MARK: - Layout variables
    
    var padding:CGFloat!
    var radius:CGFloat!
    
    // MARK: - Boolean conditionals
    
    var isSwipeToDismissEnabled:Bool!
    
    // MARK: - Other
    
    var swipeToDismissDirection:UISwipeGestureRecognizerDirection?
    var backgroundBlurStyle:CustomModalBackgroundBlurStyle!
    
    // MARK: - Initialization
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, padding:CGFloat, radius:CGFloat, backgroundBlurStyle:CustomModalBackgroundBlurStyle = .none, isSwipeToDismissEnabled:Bool = true, swipeToDismissDirection:UISwipeGestureRecognizerDirection? = nil) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .overCurrentContext
        
        self.padding = padding
        self.radius = radius
        
        self.isSwipeToDismissEnabled = isSwipeToDismissEnabled
        self.swipeToDismissDirection = swipeToDismissDirection
        
        self.backgroundBlurStyle = backgroundBlurStyle
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Create swipe to dismiss
        if isSwipeToDismissEnabled {
            let swipeToDismiss = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
            if swipeToDismissDirection != nil {
                swipeToDismiss.direction = swipeToDismissDirection!
            }
            view.addGestureRecognizer(swipeToDismiss)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // MARK: - Initialize content view
        // Move all of the root view's subviews into contentView
        contentView = UIView(frame: view.frame)
        view.addSubview(contentView)
        for view in self.view.subviews {
            if view != contentView {
                view.removeFromSuperview()
                contentView.addSubview(view)
                view.autoresizingMask = [
                    .flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin,
                    .flexibleLeftMargin, .flexibleWidth, .flexibleHeight
                ]
                view.translatesAutoresizingMaskIntoConstraints = true
            }
        }
        automaticallyAdjustsScrollViewInsets = false
        
        contentView.backgroundColor = Color(.transparent)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = radius
        contentView.frame = CGRect(x: padding, y: padding, width: view.frame.width - 2 * padding, height: view.frame.height - 2 * padding)
        
        // MARK: - Set background blur
        
        view.backgroundColor = backgroundBlurStyle == .dark ? Color(.darkGray).withAlphaComponent(0.4) : Color(.transparent)
        
        // Blur background, if needed
        if backgroundBlurStyle != .none {
            view.blurBackground(animated: true)
        }
    }
    
    /// Dismisses Custom Modal View Controller on swipe
    @objc func didSwipe(_ sender:UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIView
extension UIView {
    
    /// Blurs the background of a UIView
    func blurBackground(animated:Bool = false, duration:Double = 0.0) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        blurEffectView.cornerRadius = cornerRadius
        blurEffectView.layer.cornerRadius = cornerRadius
        
        blurEffectView.layer.masksToBounds = true
        blurEffectView.clipsToBounds = true
        
        self.addSubview(blurEffectView)
        self.sendSubview(toBack: blurEffectView)
        
        if animated {
            blurEffectView.alpha = 0
            
            UIView.animate(withDuration: duration) {
                blurEffectView.alpha = 1
            }
        }
    }
    
}
