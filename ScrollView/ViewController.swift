//
//  ViewController.swift
//  ScrollView
//
//  Created by Yu, Huiting on 5/10/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tbview: TBView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let v = UINib(nibName: "TBView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? TBView {
            tbview = v
            tbview?.dataSource = self
            tbview?.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 500))
            self.view.addSubview(tbview!)
            tbview?.contentSize = CGSize(width: 300, height: 3000)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
extension ViewController: TBViewDataSource {
    func numberOfRows() -> Int {
        return 30
    }
    func cellForRowAtIndexPath(_ tv: TBView, _ indexPath: IndexPath) -> UIView {
        if let v = tv.dequeueView(at: indexPath) {
            return v
        } else {
            let v = UIView()
            v.backgroundColor = indexPath.item % 2 == 0 ? UIColor.brown : UIColor.yellow
            return v
        }
    }
}
