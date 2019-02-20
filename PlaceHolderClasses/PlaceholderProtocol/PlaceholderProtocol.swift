//
//  TableViewProtocol.swift
//  TabelViewProtocol
//
//  Created by Darshan Mothreja on 24/02/18.
//

import UIKit

public protocol PlaceholderDelegate: class {
    func placeHolderActionOn(_ view: Any )
}

protocol PlaceholderProtocol {
    func showBackgroundView(_ image: UIImage?, _ buttonTitle: String? , _ title:  String?,  _ subTitle: String? , _ showLoading: Bool? )
    func showDefault()
    func showError(message: String)
    func showLoading()
    func showNoResults()
    func showNoSearchResult()
    func showNoConnection()
    func show(title: String?, subTitle : String?, buttonTitle: String?)
}


extension PlaceholderProtocol {

  public  func showError(message : String) {
        self.showBackgroundView( #imageLiteral(resourceName: "no_results"), NSLocalizedString("TRY_AGAIN", comment: ""), message, nil, false)
    }

  public  func show(title: String?, subTitle : String?, buttonTitle: String?) {
        self.showBackgroundView( nil,  buttonTitle, title, subTitle, false)
    }

    public func showLoading() {
        self.showBackgroundView(nil, nil, nil, nil, true)
    }

    public func showNoResults() {
        self.showBackgroundView(#imageLiteral(resourceName: "no_results"), nil, NSLocalizedString("DATA_UNAVAILABLE", comment: ""), NSLocalizedString("WE_CANT_FIND_WHAT_YOU_LOOKING_FOR", comment: ""), false)
    }

    public func showNoSearchResult() {
        self.showBackgroundView(nil, NSLocalizedString("SEARCH_AGAIN", comment: ""), NSLocalizedString("NO_RESULTS_FOUND", comment: ""), NSLocalizedString("SEARCH_AGAIN_DETAIL", comment: ""), false)
    }

    public func showNoConnection() {
        self.showBackgroundView(nil, NSLocalizedString("TRY_AGAIN", comment: ""), NSLocalizedString("WHOOPS!", comment: ""), NSLocalizedString("SLOW_INTERNET" , comment: ""), false)
    }
    
}
