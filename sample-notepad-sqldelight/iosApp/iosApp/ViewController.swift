//
//  ViewController.swift
//  calculator
//
//  Created by jetbrains on 01/12/2017.
//  Copyright © 2017 JetBrains. All rights reserved.
//

import UIKit
import NotepadArchitecture

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let noteModel =  NotepadArchitectureNoteModel()
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var inputDescription: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var notes:[NotepadArchitectureNote]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteModel.doInitUpdate(proc:updateUi)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        noteModel.runUpdate()
    }
    
    deinit {
        noteModel.clearUpdate()
    }
    
    func updateUi(notes:[NotepadArchitectureNote]) -> NotepadArchitectureStdlibUnit{
        self.notes = notes
        tableView.reloadData()
        inputButton.isEnabled = true
        print("array size \(notes.count)")
        return NotepadArchitectureStdlibUnit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func insertStuffAction(_ sender: Any) {
        inputButton.isEnabled = false
        
        noteModel.insertNote(title: inputText.text!, description: inputDescription.text!)
        
        inputText.text = ""
        inputDescription.text = ""
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.notes == nil)
        {return 0}
        else
        {return self.notes!.count}
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        let note = self.notes![indexPath.row]
        // set the text from the data model
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.notes![indexPath.row]
        
        print("Description: \(note.note!)")
    }
}


