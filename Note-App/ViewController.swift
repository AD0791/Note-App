//
//  ViewController.swift
//  Note-App
//
//  Created by Alexandro Disla on 8/13/20.
//  Copyright © 2020 Alexandro Disla. All rights reserved.
//

import UIKit


protocol DataDelegate {
    func updateArray(newArray:String)
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray = [Notes]()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        if segue.identifier == "updateNoteSegue"{
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        } else{
            vc.update = false
        }
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "protoypeCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        let object = notesArray[indexPath.row]
        cell.textLabel?.text = object.title
        //cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    

    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}


extension ViewController: DataDelegate{
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Notes].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
        }catch{
            print("failed to decode")
        }
        self.notesTableView.reloadData()
    }
}



