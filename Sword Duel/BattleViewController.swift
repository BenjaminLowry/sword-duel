//
//  BattleViewController.swift
//  Sword Duel
//
//  Created by Ben LOWRY on 2/3/17.
//  Copyright © 2017 Ben LOWRY. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    //labels for player 1
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1DamageIndicator: UILabel!
    @IBOutlet weak var player1HealthLabel: UILabel!
    
    //labels for player 2
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2DamageIndicator: UILabel!
    @IBOutlet weak var player2HealthLabel: UILabel!
    
    //player 1 sword
    @IBOutlet weak var player1ImageView: UIImageView!
    
    //player 2 sword
    @IBOutlet weak var player2ImageView: UIImageView!
    
    /*
     * LIST OF PLAYER 1 ATTRIBUTES
     */
    
    var player1Name: String!
    
    var player1Dexterity: Int!
    var player1Strength: Int!
    var player1Courage: Int!
    var player1Magic: Int!
    var player1Endurance: Int!
    
    var player1Health = 150
    
    /*
     * LIST OF PLAYER 2 ATTRIBUTES
     */
    
    var player2Name: String!
    
    var player2Dexterity: Int!
    var player2Strength: Int!
    var player2Courage: Int!
    var player2Magic: Int!
    var player2Endurance: Int!
    
    var player2Health = 150
    
    //whose turn it is
    var turn = "Player 1"
    
    //label to be shown when someone wins
    var winningLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup players health
        player1Health += player1Endurance * 5
        player2Health += player2Endurance * 5
        
        //setup the UI
        setupUI()
        
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        //start the game
        startGame()
        
    }
    
    func startGame() {
        
        
        //create timer that will play a turn every 1.5 seconds
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { timer in
            
            if self.turn == "Player 1" { //if it is player 1's turn
                
                //do the stabbing animation
                self.player1Stab()
                
                //get the damage amount from the function
                let damage = self.determineDamage(dexterity: self.player1Dexterity, strength: self.player1Strength, courage: self.player1Courage, magic: self.player1Magic)
                
                //set the damage indicator label's text to the damage
                self.player2DamageIndicator.text = "-\(damage)"
                
                //animate the damage indicator showing up, and then hiding
                UIView.animate(withDuration: 0.5, animations: {
                    self.player2DamageIndicator.alpha = 1.0
                }, completion: { finished in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.player2DamageIndicator.alpha = 0.0
                    })
                })
                
                //take away the damage from the other player's health
                self.player2Health -= damage
                
                //update the other player's health
                self.player2HealthLabel.text = String(self.player2Health)
                
                //it is now player 2's turn
                self.turn = "Player 2"
                
                //evaluate if the game is over
                if self.player2Health <= 0 {
                    timer.invalidate()
                    self.winningLabel.text = "\(self.player1Name!) Won!"
                    self.winningLabel.textAlignment = .center
                    self.winningLabel.font = UIFont(name: "AvenirNext-Medium", size: 30)
                    self.winningLabel.textColor = .red
                    self.view.addSubview(self.winningLabel)
                }
                
            } else if self.turn == "Player 2" { //do exactly the same as above, just for player 2
                
                self.player2Stab()
                
                let damage = self.determineDamage(dexterity: self.player2Dexterity, strength: self.player2Strength, courage: self.player2Courage, magic: self.player2Magic)
                
                self.player1DamageIndicator.text = "-\(damage)"
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.player1DamageIndicator.alpha = 1.0
                }, completion: { finished in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.player1DamageIndicator.alpha = 0.0
                    })
                })
                
                self.player1Health -= damage
                
                self.player1HealthLabel.text = String(self.player1Health)
                
                self.turn = "Player 1"
                
                if self.player1Health <= 0 {
                    timer.invalidate()
                    self.winningLabel.text = "\(self.player2Name!) Won!"
                    self.winningLabel.textAlignment = .center
                    self.winningLabel.font = UIFont(name: "AvenirNext-Medium", size: 30)
                    self.winningLabel.textColor = .red
                    self.view.addSubview(self.winningLabel)
                }
                
            }
            
        })
        
        
    }
    
    func determineDamage(dexterity: Int, strength: Int, courage: Int, magic: Int) -> Int {
        
        //our variable to hold how much damage
        var damage = 0
        
        //our dexterity attribute will just increase the base damage
        damage += dexterity * 2
        
        //our strength attribute will increase the possibility of a large attack
        let maxStrengthBonus = Double(strength) * 4
        damage += Int(drand48() * maxStrengthBonus)
        
        //our courage attribute will decrease the chances of a zero-damaged attack
        let courageBonus = Double(courage) * 0.02
        if drand48() + courageBonus < 0.30 {
            return 0
        }
        
        //our magic attribute will increase the chance of a critical attack
        let magicBonus = Double(magic) * 0.03
        if drand48() + magicBonus > 0.92 {
            damage += 40
        }
        
        //return the damage to be used in our "startGame" func
        return damage
        
    }
    
    /******************************/
    /* DON'T TOUCH THE CODE BELOW */
    /******************************/
    
    
    func player1Stab() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.player1ImageView.frame.origin.x += 30
            self.player1ImageView.frame.origin.y += 30
            
        }, completion: { bool in
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.player1ImageView.frame.origin.x -= 30
                self.player1ImageView.frame.origin.y -= 30
                
            })
            
        })
        
    }
    
    func player2Stab() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.player2ImageView.frame.origin.x -= 30
            self.player2ImageView.frame.origin.y -= 30
            
        }, completion: { bool in
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.player2ImageView.frame.origin.x += 30
                self.player2ImageView.frame.origin.y += 30
                
            })
            
        })
        
    }
    
    func setupUI() {
        
        player1NameLabel.adjustsFontSizeToFitWidth = true
        player2NameLabel.adjustsFontSizeToFitWidth = true
        
        let swordImage = #imageLiteral(resourceName: "2000px-Sword_01.svg.png")
        
        player1ImageView.image = UIImage(cgImage: swordImage.cgImage!, scale: 1.0, orientation: .downMirrored)
        
        player2ImageView.image = UIImage(cgImage: swordImage.cgImage!, scale: 1.0, orientation: .left)
        
        player1HealthLabel.text = String(player1Health)
        player2HealthLabel.text = String(player2Health)
        
        player1DamageIndicator.alpha = 0
        player2DamageIndicator.alpha = 0
        
        winningLabel = UILabel(frame: self.view.frame)
        
        player1NameLabel.text = player1Name
        player2NameLabel.text = player2Name
        
    }

}
