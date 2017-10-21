//
//  MemeDetailViewController.swift
//  preMeme
//
//  Created by Rahul Dhiman on 21/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var DetailPic: UIImageView!
    var meme:Meme!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    override func viewWillAppear(_ animated: Bool) {
        DetailPic.image = meme.memedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
