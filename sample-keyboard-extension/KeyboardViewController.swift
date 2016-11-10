//
//  KeyboardViewController.swift
//  sample-keyboard-extension
//
//  Created by rocker on 20161103.
//  Copyright © 2016 rocker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var buttons: [UIButton]!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // create the button
        let buttonA = UIView()
        buttonA.backgroundColor = UIColor.init(white: 1, alpha: 1)
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        
        // create button label
        let buttonALabel = UILabel()
        buttonALabel.translatesAutoresizingMaskIntoConstraints = false
        buttonALabel.text = "A"
        
        // add button label to button
        buttonA.addSubview(buttonALabel)
        
        // add button to keyboard's view
        self.view.addSubview(buttonA)
        
        // center button label within button
        buttonALabel.centerXAnchor.constraint(equalTo: buttonA.centerXAnchor).isActive = true
        buttonALabel.centerYAnchor.constraint(equalTo: buttonA.centerYAnchor).isActive = true
        
        // center button with self.view
        buttonA.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonA.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // set button's width and height
        buttonA.widthAnchor.constraint(equalToConstant: 20).isActive = true
        buttonA.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // call the superclass' function because you almost always should
        super.touchesBegan(touches, with: event)
        
        // get the user's touch
        let touch = touches.first
        
        // get the coordinates (point) of the touch
        let touchPoint = touch?.location(in: view)
        
        // get the view (key) the touch is in
        let touchView = view.hitTest(touchPoint!, with: nil)
        
        // get the key's label
        let touchViewLabel = touchView?.subviews[0]
        
        // downcast the label from UIView to UILabel so we can access the "text" property
        let touchViewLabelRaw = touchViewLabel as! UILabel
        
        // insert the label's text into the text field
        textDocumentProxy.insertText(touchViewLabelRaw.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
