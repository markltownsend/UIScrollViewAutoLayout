//
//  MyTableView.swift
//  UIScrollViewAutoLayout
//
//  Created by Mark Townsend on 12/19/22.
//

import UIKit

class MyTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
