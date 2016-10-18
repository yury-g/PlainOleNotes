//
//  DetailViewController.swift
//  PlainOleNotes
//
//  Created by Yury Gitman on 10/17/16.
//  Copyright © 2016 com.yuryg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UITextView!


    func configureView() {
        
        if objects.count == 0{
            return
        }
        
        // Update the user interface for the detail item.
            if let label = self.detailDescriptionLabel {    // why if let here?
                label.text = objects[currentIndex]
                if label.text == BLANK_NOTE{
                    label.text = ""
                }
            }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        detailViewController = self
        
        detailDescriptionLabel.delegate = self
        self.configureView()
        detailDescriptionLabel.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)  // ???
        
        if objects.count == 0{     // if no object in array
            return
        }
        
        
        objects[currentIndex] = detailDescriptionLabel.text   // populate array with what was typed
        if  detailDescriptionLabel.text == ""{      //  if the note is created but blank.
            objects[currentIndex] = BLANK_NOTE
        }
        saveAndUpdate()
    }
    
    func saveAndUpdate(){
        masterView?.save()
        masterView?.tableView.reloadData()
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        objects[currentIndex] = detailDescriptionLabel.text
        saveAndUpdate()
    }
    
}

