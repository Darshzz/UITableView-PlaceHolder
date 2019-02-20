//
//  BackgroundView.swift
//  TabelViewProtocol
//
//  Created by Darshan Mothreja on 20/02/18.


import UIKit

class BackgroundView: UIView {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var actionButton: UIButton?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var loaderTriangle: RotationLoader?

    var onRetryButtonAction : (()->(Void))?

    var backView: UIView {
        return self
    }
    
    @IBAction func btnRetry_Action(_ sender: Any) {
        if onRetryButtonAction != nil {
            onRetryButtonAction?()
        }
    }
    
    public func setUpBackGroundView(_ image: UIImage?, _ buttonTitle: String? , _ title:  String?,  _ subTitle: String? , _ showLoading: Bool? ) {
        actionButton?.setTitle(buttonTitle, for: .normal)
        actionButton?.isHidden = (buttonTitle == nil)
        
        titleLabel?.text = title
        titleLabel?.isHidden = (title == nil)
        
        subtitleLabel?.text = subTitle
        subtitleLabel?.isHidden = (subTitle == nil)
        
        if image != nil {
            imgView.image = image
        }
        
        loaderTriangle?.stopAnimating()
        loaderTriangle?.isHidden = !(showLoading!)
        if  showLoading! {
            DispatchQueue.main.async {
                self.loaderTriangle?.startAnimating()                
            }
        }
     
    }
    
}


