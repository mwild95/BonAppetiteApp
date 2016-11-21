//
//  ViewController.swift
//  Ordering
//
//  Created by Michael Wild on 08/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blackColor()
        self.view.
        
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        button.backgroundColor = .blueColor()
        button.setTitle("Test Button", forState: .Normal)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
    
       // let switchTog = UISwitch( frame: CGRect(x:50, y:50, width:100, height:50))
        //self.view.addSubview(switchTog)
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    


}

