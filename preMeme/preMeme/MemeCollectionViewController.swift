//
//  MemeCollectionViewController.swift
//  preMeme
//
//  Created by Rahul Dhiman on 21/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController{

    var memes:[Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
        
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    collectionView?.reloadData()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }


   


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.Pic2?.image = meme.memedImage
        // Configure the cell
    
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        controller.meme = memes[indexPath.item]
        self.navigationController!.pushViewController(controller, animated: true)
    }

    

    @IBAction func addMeme(_ sender: Any) {
        let editor = storyboard!.instantiateViewController(withIdentifier: "addMeme")
        present(editor, animated: true, completion: nil)
    }
    
}
