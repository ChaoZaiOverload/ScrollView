//
//  ViewController.swift
//  ScrollView
//
//  Created by Yu, Huiting on 5/10/18.
//  Copyright © 2018 Yu, Huiting. All rights reserved.
//

import UIKit

extension UIView {
    
    func autoPinEdgesToSuperviewEdges(insets: UIEdgeInsets = .zero) {
        guard let sv = superview else { assertionFailure("no superview is set"); return }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: sv.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor, constant: insets.right).isActive = true
        topAnchor.constraint(equalTo: sv.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: insets.bottom).isActive = true
    }
}
class ViewController: UIViewController {

    static var instanceOfView: Int = 0
    
    private var tbview: TBView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let v = UINib(nibName: "TBView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? TBView {
            tbview = v
            tbview?.dataSource = self
            self.view.addSubview(tbview!)
        }
        tbview?.autoPinEdgesToSuperviewEdges()
        tbview?.contentSize.height = 3000
        
    }

    override func viewDidAppear(_ animated: Bool) {
        tbview?.reload()
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
        
        let v: UIView
        if let dv = tv.dequeueView(at: indexPath) {
            v = dv
        } else {
            v = UIView()
            print("instanceOfView = \(ViewController.instanceOfView)")
            ViewController.instanceOfView += 1
        }
        v.backgroundColor = indexPath.item % 2 == 0 ? UIColor.brown : UIColor.yellow
        return v
    }
}
