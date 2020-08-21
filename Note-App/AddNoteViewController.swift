//
//  AddNoteViewController.swift
//  Note-App
//
//  Created by Alexandro Disla on 8/21/20.
//  Copyright © 2020 Alexandro Disla. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    var update = false
    var note: Notes?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    @IBAction func deleteClick(_ sender: Any) {
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)

    }
    
    
    
    
    @IBAction func saveClick(_ sender: Any) {
       
        if update == false {
            APIFunctions.functions.addNote(title: titleTextField.text!, date: "PlaceHolder", note: bodyTextView.text!)
        } else {
            APIFunctions.functions.updateNote(title: titleTextField.text!, date: "PlaceHolder", note: bodyTextView.text!, id:note!._id)
        }
        
        //APIFunctions.functions.addNote(title: titleTextField.text!, date: "PlaceHolder", note: bodyTextView.text!)

        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false{
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update == true {
            titleTextField.text = note!.title
            bodyTextView.text = note!.note
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
