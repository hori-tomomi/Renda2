//
//  ViewController.swift
//  Renda2
//
//  Created by Tomomi Hori on 2022/02/13.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var tapButton: UIButton!
    
    let firestore = Firestore.firestore()
    
    var tapCount = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapButton.layer.cornerRadius = 125
        // Do any additional setup after loading the view.
        
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
                    if error != nil {
                        print("エラーが発生しました")
                        print(error)
                        return
                    }
                    let data = snapshot?.data()
                    if data == nil {
                        print("データがありません")
                        return
                    }
                    let count = data!["count"] as? Int
                    if count == nil {
                        print("countという対応する値がありません")
                        return
                    }
                    self.tapCount = count!
                    self.countLabel.text = String(count!)
                }
    }
    
    @IBAction func tapTapButton() {
        
        tapCount = tapCount + 1
        countLabel.text = String(tapCount)
        
        firestore.collection("counts").document("share").setData(["count" : tapCount])
        
    }


}

