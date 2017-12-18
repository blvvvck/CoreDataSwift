//
//  NoteViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 02/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    
    var dataTransferDelagete: DataTransferProtocol?
    let placeholderText = "What's new?"
    let placeholderTextColor = UIColor.lightGray
    let noteTextColor = UIColor.black
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        noteTextView.delegate = self
        noteTextView.text = placeholderText
        noteTextView.textColor = placeholderTextColor
        doneButton.isEnabled = false
        
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if noteTextView.textColor == placeholderTextColor {
            noteTextView.text = ""
            noteTextView.textColor = noteTextColor
            doneButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if noteTextView.text == "" {
            
            noteTextView.text = placeholderText
            noteTextView.textColor = placeholderTextColor
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        guard let note = noteTextView.text else { return }
        
        dataTransferDelagete?.didPressDone(with: note)
        
        dismiss(animated: true, completion: nil)
    }
}
