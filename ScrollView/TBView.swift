//
//  TBView.swift
//  ScrollView
//
//  Created by Yu, Huiting on 5/18/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import Foundation
import UIKit

protocol TBViewDataSource {
    func numberOfRows() -> Int
    func cellForRowAtIndexPath(_ tv: TBView,  _ indexPath: IndexPath) -> UIView
}

class TBView: UIScrollView {
    @IBOutlet fileprivate weak var contentView: UIView!
    
    private var queue: [UIView] = []
    private var visibleCells: [IndexPath: UIView] = [:]
    var dataSource: TBViewDataSource?
    
    override func awakeFromNib() {
        self.delegate = self
    }
    
    func dequeueView(at indexPath: IndexPath) -> UIView? {
        if queue.isEmpty {
            return nil
        }
        return queue.removeFirst()
    }
    
    
}

extension TBView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let datasource = dataSource else {
            fatalError("no datasource")
        }
        let offset = scrollView.contentOffset
        let visibleFrame = CGRect(origin: offset, size: scrollView.frame.size)
        visibleCells.removeAll()
        for view in scrollView.subviews {
            if view.frame.intersects(visibleFrame) {
                visibleCells[IndexPath(item: Int(view.frame.origin.y/40), section: 0)] = view
            } else {
                view.removeFromSuperview()
                queue.append(view)
            }
        }
        for i in 0..<Int((visibleFrame.origin.y + visibleFrame.size.height)/40) {
            if nil != visibleCells[IndexPath(item: i, section: 0)] {
                continue
            }
            let cell = datasource.cellForRowAtIndexPath(scrollView as! TBView, IndexPath(item: i, section: 0))
            cell.frame = CGRect(x: 0, y: CGFloat(40*i), width: visibleFrame.size.width, height: 40.0)
            contentView.addSubview(cell)
        }
        
    }
    
}
