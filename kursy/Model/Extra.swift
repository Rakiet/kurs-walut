//
//  Extra.swift
//  kursy
//
//  Created by Piotr Żakieta on 29/03/2022.
//

import Foundation
import UIKit
struct Extra {

var activityIndicator: UIActivityIndicatorView?

    mutating func prepareactivityIndicator(sentView: UIView){
    if #available(iOS 13.0, *) {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        
        activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
        sentView.addSubview(activityIndicator!)
        activityIndicator!.centerXAnchor.constraint(equalTo: sentView.centerXAnchor).isActive = true
        activityIndicator!.centerYAnchor.constraint(equalTo: sentView.centerYAnchor).isActive = true
    } else {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator?.color = UIColor.green
        activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
        sentView.addSubview(activityIndicator!)
        activityIndicator!.centerXAnchor.constraint(equalTo: sentView.centerXAnchor).isActive = true
        activityIndicator!.centerYAnchor.constraint(equalTo: sentView.centerYAnchor).isActive = true
    }
}
}
