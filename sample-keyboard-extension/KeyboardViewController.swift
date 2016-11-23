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
        
        /*
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
        
        // add button to self.view
        self.view.addSubview(buttonA)
        
        // center button label within button
        buttonALabel.centerXAnchor.constraint(equalTo: buttonA.centerXAnchor).isActive = true
        buttonALabel.centerYAnchor.constraint(equalTo: buttonA.centerYAnchor).isActive = true
        
        // center button with self.view
        buttonA.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonA.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // set button's width and height
        buttonA.widthAnchor.constraint(equalToConstant: 30).isActive = true
        buttonA.heightAnchor.constraint(equalToConstant: 50).isActive = true
        */
        
        // MAKE LETTER KEYS
        
        // the alphabet arranged in QWERTY order
        let alphaChars = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M"]
        
        // make empty button array to append to later
        var buttons = [UIView]()
        
        // loop over alphaChars appending buttons to "buttons" as we go
        for alphaChar in alphaChars {
            buttons.append(makeButton(character: alphaChar))
        }
        
        // add buttons to self.view
        for button in buttons {
            self.view.addSubview(button)
        }
        
        // ADD LETTER KEYS CONSTRAINTS
        
        // constants describing number of keys in each row
        // bottom row will take up slack/overflow
        let topRowNumButtons = 10
        let midRowNumButtons = 9
        
        // loop over buttons array setting constraints
        for (i, button) in buttons.enumerated() {
            // consider each button as a row
            if i < topRowNumButtons {
                // top row
                
                // align the top of all buttons in row with the top of self.view
                button.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                
                if i == 0 {
                    // align the leftmost button's left side with the left side of self.view
                    button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                } else {
                    // else align left side of button with right side of button to the left
                    button.leftAnchor.constraint(equalTo: buttons[i - 1].rightAnchor).isActive = true
                }
            } else if i < topRowNumButtons + midRowNumButtons {
                // mid row
                
                // align top of all buttons in row with bottom of top row's first button
                button.topAnchor.constraint(equalTo: buttons[0].bottomAnchor).isActive = true
                
                if i == topRowNumButtons {
                    // align the leftmost button's left side with the left side of self.view
                    button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                } else {
                    // else align left side of button with right side of button to the left
                    button.leftAnchor.constraint(equalTo: buttons[i - 1].rightAnchor).isActive = true
                }
            } else {
                // bottom row
                
                // align top of all buttons in row with bottom of mid row's first button
                button.topAnchor.constraint(equalTo: buttons[topRowNumButtons].bottomAnchor).isActive = true
                
                if i == topRowNumButtons + midRowNumButtons {
                    // align the leftmost button's left side with the left side of self.view
                    button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                } else {
                    // else align left side of button with right side of button to the left
                    button.leftAnchor.constraint(equalTo: buttons[i - 1].rightAnchor).isActive = true
                }  
            }
        }
        
        // BACKSPACE KEY
 
        // make backspace key
        let backspaceKey = makeButton(character: "<-")
        
        // set tag so we can identify backspace key when processing touches
        // 10 is arbitrary. However, UIView has a default tag 0 fyi.
        backspaceKey.tag = 10
 
        // add backpace key to self.view
        self.view.addSubview(backspaceKey)
        
        // set constraints for lower right hand corner position
        // align right side of backspace key with right side of self.view
        backspaceKey.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        // align bottom of backspace key with bottom of self.view
        backspaceKey.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func makeButton(character: String) -> UIView {
        // create the button
        let buttonA = UIView()
        buttonA.backgroundColor = UIColor.init(white: 1, alpha: 1)
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        
        // create button label
        let buttonALabel = UILabel()
        buttonALabel.translatesAutoresizingMaskIntoConstraints = false
        buttonALabel.text = character
        
        // add button label to button
        buttonA.addSubview(buttonALabel)
        
        // add button to self.view
        //self.view.addSubview(buttonA)
        
        // center button label within button
        buttonALabel.centerXAnchor.constraint(equalTo: buttonA.centerXAnchor).isActive = true
        buttonALabel.centerYAnchor.constraint(equalTo: buttonA.centerYAnchor).isActive = true
        
        // center button with self.view
        //buttonA.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //buttonA.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // set button's width and height
        buttonA.widthAnchor.constraint(equalToConstant: 30).isActive = true
        buttonA.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return buttonA
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
        
        // if key is backspace
        if touchView?.tag == 10 {
            // backspace one character and early return
            self.textDocumentProxy.deleteBackward()
            return
        }
        
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
