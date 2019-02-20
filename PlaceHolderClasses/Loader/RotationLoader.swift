//
//  RotationLoader.swift
//  
//  Created by Darshan Mothreja on 30/11/17.
//

import UIKit

class RotationLoader : UIView{
    
    var imageView: UIImageView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupImageView(){
        self.imageView = UIImageView(frame: self.bounds)
        self.imageView!.image = #imageLiteral(resourceName: "loader")
        self.addSubview(self.imageView!)
    }
    
    func stopAnimating(){
        
        guard let imageV = imageView else { return }
        
        if let subLayers = imageV.layer.sublayers, subLayers.count > 0 {
            for layr in subLayers {
                layr.removeFromSuperlayer()
            }
        }
        imageV.layer.removeAllAnimations()
    }
    
    func startAnimating() {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 360 * (CGFloat.pi/180)
        let innerAnimationDuration : CGFloat = 1.0
        rotationAnimation.duration = Double(innerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        self.imageView!.layer.add(rotationAnimation, forKey: "rotateInner")
    }
}
