//
//  MEME.swift
//  preMeme
//
//  Created by Rahul Dhiman on 21/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    init(topText: String!, bottomText: String!, orignalImage: UIImage!, memedImage: UIImage!) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = orignalImage
        self.memedImage = memedImage
    }
}
