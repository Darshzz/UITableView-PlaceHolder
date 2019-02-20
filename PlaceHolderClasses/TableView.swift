//
//  TableView.swift
//  PlaceHolderDemo
//
//  Created by Darshan Mothreja on 24/02/18.
//

import UIKit

class TableView: UITableView {
    
    public weak var placeholderDelegate: PlaceholderDelegate?
    fileprivate var defaultHeaderView: UIView?
    fileprivate weak var tempDataSource: UITableViewDataSource?
    internal var defaultSeparatorStyle: UITableViewCellSeparatorStyle!
    fileprivate var defaultAlwaysBounceVertical: Bool!
    
    weak open override var dataSource: UITableViewDataSource? {
        didSet {
            if tempDataSource == nil {
                tempDataSource = dataSource
            }
        }
    }
    
    override var tableHeaderView: UIView? {
        didSet {
            if tableHeaderView != nil {
                defaultHeaderView = tableHeaderView
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    private func setup() {
        //register the placeholder view cell
        defaultSeparatorStyle = separatorStyle
        defaultAlwaysBounceVertical = alwaysBounceVertical
    }
    
    fileprivate func switchTo(dataSource theDataSource: UITableViewDataSource?) {
        // switch data source & delegate to show defult table view data
        dataSource = theDataSource
        super.reloadData()
    }
    
}

// MARK: Utilities methods to switch to placeholders
extension TableView: PlaceholderProtocol {

    public func showDefault() {
        separatorStyle  = defaultSeparatorStyle
        tableHeaderView = defaultHeaderView
        
        alwaysBounceVertical = true
        self.backgroundView = nil
        
        switchTo(dataSource: tempDataSource)
    }
    
    public func showBackgroundView(_ image: UIImage?, _ buttonTitle: String? , _ title:  String?,  _ subTitle: String? , _ showLoading: Bool? ) {
       
        //Remove cells from table view except UIRefreshControl
        for view in self.subviews {
            guard view is UIRefreshControl else {
                view.removeFromSuperview()
                continue
            }
        }
        
        //Add background view
        let viewBackground = UINib.init(nibName: "BackgroundView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BackgroundView
        separatorStyle       = .none
        alwaysBounceVertical = false
        
        tableHeaderView = nil
        
        viewBackground.setUpBackGroundView(image, buttonTitle, title, subTitle, showLoading)
        self.backgroundView = viewBackground
        viewBackground.onRetryButtonAction = {[unowned self] in
            self.placeholderDelegate?.placeHolderActionOn(self)
        }
    }
}


