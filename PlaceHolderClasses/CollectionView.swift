//
//  CollectionView.swift
//  TabelViewProtocol
//
//  Created by Darshan Mothreja on 26/02/18.
//

import UIKit

class CollectionView: UICollectionView {
    public weak var placeholderDelegate: PlaceholderDelegate?
    fileprivate weak var tempDataSource: UICollectionViewDataSource?
    fileprivate var defaultLayout: UICollectionViewLayout!
    fileprivate var defaultAlwaysBounceVertical: Bool!
    
    open override weak var dataSource: UICollectionViewDataSource? {
        didSet {
            if tempDataSource == nil {
                tempDataSource = dataSource
            }
        }
    }
    
    // MARK: - init methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    private func setup() {
        defaultAlwaysBounceVertical = alwaysBounceVertical
        defaultLayout = collectionViewLayout
    }
    
    fileprivate func switchTo(dataSource theDataSource: UICollectionViewDataSource?) {
        // switch data source & delegate to show defult table view data
        dataSource = theDataSource
        super.reloadData()
    }
}

// MARK: Utilities methods to switch to placeholders
extension CollectionView : PlaceholderProtocol {
    
    public func showDefault() {
        alwaysBounceVertical = true
        self.backgroundView = nil
        switchTo(dataSource: tempDataSource)
        collectionViewLayout = defaultLayout
    }
    
    public func showBackgroundView(_ image: UIImage?, _ buttonTitle: String? , _ title:  String?,  _ subTitle: String? , _ showLoading: Bool? ) {
        
        //Remove cells from collection view except UIRefreshControl
        for view in self.subviews {
            guard view is UIRefreshControl else {
                view.removeFromSuperview()
                continue
            }
        }
        
        //Add background view
        let viewBackground = UINib.init(nibName: "BackgroundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BackgroundView
        alwaysBounceVertical = false
        viewBackground.setUpBackGroundView(image, buttonTitle, title, subTitle, showLoading)
        self.backgroundView = viewBackground
        viewBackground.onRetryButtonAction = {[unowned self] in
            self.placeholderDelegate?.placeHolderActionOn(self)
        }
    }
}
