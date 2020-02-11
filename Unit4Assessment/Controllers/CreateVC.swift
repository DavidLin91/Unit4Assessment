//
//  CreateVC.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {
    
    
    override func viewWillLayoutSubviews() {
        self.navigationItem.title = "Create Quiz"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(buttonPressed(_:)))
    }
    
    
    @objc func buttonPressed(_ sender: UIBarButtonItem){
          // put action here
       }
    
    
}
