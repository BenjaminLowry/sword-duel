//
//  ViewController.swift
//  Sword Duel
//
//  Created by Ben LOWRY on 2/2/17.
//  Copyright © 2017 Ben LOWRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    /*
     * LIST OF UI OBJECTS FOR PLAYER 1
     */
    
    @IBOutlet weak var player1NameTextField: UITextField!
    @IBOutlet weak var player1TotalLabel: UILabel!
    
    @IBOutlet weak var player1DexterityLabel: UILabel!
    @IBOutlet weak var player1StrengthLabel: UILabel!
    @IBOutlet weak var player1CourageLabel: UILabel!
    @IBOutlet weak var player1MagicLabel: UILabel!
    @IBOutlet weak var player1EnduranceLabel: UILabel!
    
    @IBOutlet weak var player1DexterityStepper: UIStepper!
    @IBOutlet weak var player1StrengthStepper: UIStepper!
    @IBOutlet weak var player1CourageStepper: UIStepper!
    @IBOutlet weak var player1MagicStepper: UIStepper!
    @IBOutlet weak var player1EnduranceStepper: UIStepper!
    
    /*
     * LIST OF UI OBJECTS FOR PLAYER 2
     */
    
    @IBOutlet weak var player2NameTextField: UITextField!
    @IBOutlet weak var player2TotalLabel: UILabel!
    
    @IBOutlet weak var player2DexterityLabel: UILabel!
    @IBOutlet weak var player2StrengthLabel: UILabel!
    @IBOutlet weak var player2CourageLabel: UILabel!
    @IBOutlet weak var player2MagicLabel: UILabel!
    @IBOutlet weak var player2EnduranceLabel: UILabel!
    
    @IBOutlet weak var player2DexterityStepper: UIStepper!
    @IBOutlet weak var player2StrengthStepper: UIStepper!
    @IBOutlet weak var player2CourageStepper: UIStepper!
    @IBOutlet weak var player2MagicStepper: UIStepper!
    @IBOutlet weak var player2EnduranceStepper: UIStepper!
    
    //LIST OF STEPPERS FOR EACH PLAYER
    var player1Steppers: [UIStepper]!
    var player2Steppers: [UIStepper]!
    
    var player1Total: Int = 0
    var player2Total: Int = 0
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        //find which stepper was changed
        switch sender.tag {
        case 1: //player 1 dexterity
            player1DexterityLabel.text = "Dexterity: \(Int(sender.value))" //update the label for the change in stepper
        case 2: //player 1 strength
            player1StrengthLabel.text = "Strength: \(Int(sender.value))"
        case 3: //player 1 courage
            player1CourageLabel.text = "Courage: \(Int(sender.value))"
        case 4: //player 1 magic
            player1MagicLabel.text = "Magic: \(Int(sender.value))"
        case 5: //player 1 endurance
            player1EnduranceLabel.text = "Endurance: \(Int(sender.value))"
        case 6: //player 2 dexterity
            player2DexterityLabel.text = "Dexterity: \(Int(sender.value))"
        case 7: //player 2 strength
            player2StrengthLabel.text = "Strength: \(Int(sender.value))"
        case 8: //player 2 courage
            player2CourageLabel.text = "Courage: \(Int(sender.value))"
        case 9: //player 2 magic
            player2MagicLabel.text = "Magic: \(Int(sender.value))"
        case 10: //player 2 endurance
            player2EnduranceLabel.text = "Endurance: \(Int(sender.value))"
        default:
            print("error")
        }
        
        
        //loop through the steppers for player 1
        player1Total = 0
        for stepper in player1Steppers {
            //add the value of the stepper to the total value
            player1Total += Int(stepper.value)
        }
        //change the text for the total label
        player1TotalLabel.text = "Total: \(player1Total)"
        
        //same as above for player 2
        player2Total = 0
        for stepper in player2Steppers {
            player2Total += Int(stepper.value)
        }
        player2TotalLabel.text = "Total: \(player2Total)"
        
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
    
        //make sure that each player has exactly 25, and if so, move to the battle screen
        if player1Total != 25 {
            showCountAlert(player: "Player 1")
        } else if player2Total != 25 {
            showCountAlert(player: "Player 2")
        } else {
            performSegue(withIdentifier: "StartGame", sender: self)
        }
        
    }
    
    /******************************/
    /* DON'T TOUCH THE CODE BELOW */
    /******************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize the array with all of the player 1 steppers in it
        player1Steppers = [player1DexterityStepper, player1StrengthStepper, player1CourageStepper, player1MagicStepper, player1EnduranceStepper]
        
        //initialize the array with all of the player 2 steppers in it
        player2Steppers = [player2DexterityStepper, player2StrengthStepper, player2CourageStepper, player2MagicStepper, player2EnduranceStepper]
        
        //set the delegates for the text field
        player1NameTextField.delegate = self
        player2NameTextField.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? BattleViewController {
            
            vc.player1Name = player1NameTextField.text!
            
            vc.player1Dexterity = Int(player1DexterityStepper.value)
            vc.player1Strength = Int(player1StrengthStepper.value)
            vc.player1Courage = Int(player1CourageStepper.value)
            vc.player1Magic = Int(player1MagicStepper.value)
            vc.player1Endurance = Int(player1EnduranceStepper.value)
            
            vc.player2Name = player2NameTextField.text!
            
            vc.player2Dexterity = Int(player2DexterityStepper.value)
            vc.player2Strength = Int(player2StrengthStepper.value)
            vc.player2Courage = Int(player2CourageStepper.value)
            vc.player2Magic = Int(player2MagicStepper.value)
            vc.player2Endurance = Int(player2EnduranceStepper.value)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showCountAlert(player: String) {
        
        let alert = UIAlertController(title: "Oops", message: "\(player)'s abilities must add up to 25!", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        self.show(alert, sender: self)
        
    }
    


}

