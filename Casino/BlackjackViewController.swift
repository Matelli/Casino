//
//  BlackjackViewController.swift
//  Casino
//
//  Created by Jonathan Schmidt on 10/06/2014.
//  Copyright (c) 2014 Matelli. All rights reserved.
//

import UIKit

class BlackjackViewController: UIViewController {

//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }
    
    var dealer = Blackjack.Game.Player()
    var player = Blackjack.Game.Player()
    var shoe = Shoe(shoeType:.Manual)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "GreenCloth"))
        self.setupGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGame() {
        //Initializes Players
        dealer = Blackjack.Game.Player()
        player = Blackjack.Game.Player()
        shoe = Shoe(shoeType:.Manual)
        
        //Start first round of playing
        self.newRound()
    }
    
    @IBAction func newGame(sender : UIButton) {
        self.setupGame()
    }
    
    @IBAction func cardRequested(sender : UIButton) {
        self.drawPlayerCard()
        if self.player.hand.value > 21 {
            let alert = UIAlertController(title: "Dommage", message: "Vous avez perdu", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {action in
                self.newRound()
                }))
            self.presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    @IBAction func stayRequested(sender : UIButton) {
        while self.dealer.hand.value < 17 {
            self.drawDealerCard(hidden: false)
        }
        for view:AnyObject in self.view.subviews {
            if let cardView = view as? CardView {
                if cardView.isDisplayingValue == false {
                    cardView.flipCardAnimatedWithCompletion { finished in
                        if self.dealer.hand.value > 21 {
                            let alert = UIAlertController(title: "Gagné", message: "La banque saute", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {value in
                                self.newRound()
                                }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else if self.dealer.hand.value > self.player.hand.value {
                            let alert = UIAlertController(title: "Dommage", message: "Vous avez perdu", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {value in
                                self.newRound()
                                }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else if self.dealer.hand.value == self.player.hand.value {
                            let alert = UIAlertController(title: "Egalité", message: "On recommence", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {value in
                                self.newRound()
                                }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Gagné", message: "Félicitations", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {value in
                                self.newRound()
                                }))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        
    }
    
    func newRound() {
            self.cleanUp()
            self.drawPlayerCard()
            self.drawDealerCard(hidden: false)
            self.drawPlayerCard()
            self.drawDealerCard(hidden: true)
    }
    
    func drawPlayerCard() {
        let card = self.shoe.drawCard()
        self.player.hand.cards += card
        let cardView = CardView()
        
        cardView.bounds.size.width = self.view.bounds.size.width / 5
        cardView.bounds.size.height = self.view.bounds.size.height / 5
        cardView.center = CGPoint(x: self.view.bounds.size.width/2, y: 0)
        
        cardView.cardValueImage = card.frontImage()
        cardView.cardCoverImage = card.backImage()
        cardView.displayValue()
        self.view.addSubview(cardView)
        
        UIView.animateWithDuration(1, animations:{
            cardView.center = CGPoint(x: cardView.bounds.size.width/1.9 * (1.0 + CGFloat(self.player.hand.cards.count)), y: self.view.bounds.size.height*3/4)
        })
    }
    
    func drawDealerCard(#hidden:Bool) {
        let card = self.shoe.drawCard()
        self.dealer.hand.cards += card
        let cardView = CardView()
        
        cardView.bounds.size.width = self.view.bounds.size.width / 5
        cardView.bounds.size.height = self.view.bounds.size.height / 5
        cardView.center = CGPoint(x: self.view.bounds.size.width/2, y: 0)
        
        cardView.cardValueImage = card.frontImage()
        cardView.cardCoverImage = card.backImage()
        if hidden{
            cardView.displayCover()
        } else {
            cardView.displayValue()
        }
        
        self.view.addSubview(cardView)
        
        UIView.animateWithDuration(1, animations:{
            cardView.center = CGPoint(x: cardView.bounds.size.width/1.9 * (1.0 + CGFloat(self.dealer.hand.cards.count)), y: self.view.bounds.size.height*2/5)
            })
    }
    
    func cleanUp() {
        self.shoe.discard += self.player.hand.cards + self.dealer.hand.cards
        self.player.hand.cards = []
        self.dealer.hand.cards = []
        for view:AnyObject in self.view.subviews {
            if let cardView = view as? CardView {
                UIView.animateWithDuration(1, animations: {
                    cardView.center = CGPoint(x: 0, y: self.view.bounds.size.height/2)
                    }, completion:{finished in
                        cardView.removeFromSuperview()
                    })
            }
        }
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
