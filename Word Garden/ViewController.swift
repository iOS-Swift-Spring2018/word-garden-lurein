//
//  ViewController.swift
//  Word Garden
//
//  Created by Enoka Jayamanne on 2/3/18.
//  Copyright © 2018 Lurein Perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        
    }
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func formatUserGuessLabel(){
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord +=  " \(letter)"
            }else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    func guessALetter(){
       formatUserGuessLabel()
        guessCount += 1
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        if wrongGuessesRemaining == 0{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !(userGuessLabel.text?.contains("_"))!{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Congratulations, you got it in \(guessCount) guesses"
        }else{
            let guess = (guessCount == 1 ? "Guess" : "Guesses")
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
       updateUIAfterGuess()
    }
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = true
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
   
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last{
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        }else{
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
       updateUIAfterGuess()
    }
    

}

