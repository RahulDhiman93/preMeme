//
//  MemeTableViewController.swift
//  preMeme
//
//  Created by Rahul Dhiman on 21/10/17.
//  Copyright © 2017 Rahul Dhiman. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    var memes:[Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableView")!
        let table = memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = table.memedImage
        cell.textLabel?.text = table.topText + " ... " + table.bottomText
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    @IBAction func addMeme(_ sender: Any) {
        
        let editor = storyboard!.instantiateViewController(withIdentifier: "addMeme")
       present(editor, animated: true, completion: nil)
        
    }
    
    
}
