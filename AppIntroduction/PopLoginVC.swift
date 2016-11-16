//
//  PopLoginVC.swift
//  AppIntroduction
//
//  Created by Waleed Hassan on 09/11/16.
//  Copyright © 2016 SchoolWork. All rights reserved.
//

import UIKit

class PopLoginVC: UIViewController {

    @IBOutlet weak var popup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popup.layer.cornerRadius = 10
        popup.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClosePopUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
