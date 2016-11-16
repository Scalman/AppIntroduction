//
//  PopSignUpVC.swift
//  AppIntroduction
//
//  Created by Waleed Hassan on 09/11/16.
//  Copyright © 2016 SchoolWork. All rights reserved.
//

import UIKit

class PopSignUpVC: UIViewController {

   
    @IBOutlet var popup: UIView!

    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    private var tmpEffect:UIVisualEffect!
    private var tmpEffectBounds:UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tmpEffect = effectView.effect
        tmpEffectBounds = effectView
        effectView.effect = nil
        
        popup.layer.cornerRadius = 5
        
        
        //popup.layer.cornerRadius = 10
        //popup.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        animateIn()
    }
    
    func animateIn(){
        self.view.addSubview(popup)
        popup.center = self.view.center
        
        popup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popup.alpha = 0
        
        UIView.animate(withDuration: 0.2){
            self.effectView.effect = self.tmpEffect
            self.popup.alpha = 1
            self.popup.transform = CGAffineTransform.identity
            
        }
        self.effectView.frame = self.view.bounds
        
    }

    @IBAction func close(_ sender: Any) {
        animateOut()
        
    }
    
    func animateOut(){
        
        //Todo sätt bounds lika stort som knappen, fixa en outlet till knappen där höjden hämtas.
       self.effectView.bounds = signUpBtn.bounds
        UIView.animate(withDuration: 0.3, animations: {
            self.popup.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popup.alpha = 0
            self.effectView.effect = nil
            
        }) {(success:Bool) in
            self.popup.removeFromSuperview()
        }
 
        
    }
    
 /*   @IBAction func closePopup(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
