//
//  AboutViewController.swift
//  SubwayCalc
//
//  Created by Katie Smillie on 7/14/15.
//  Copyright (c) 2015 Katie Smillie. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }
    
    func setupMenu() {
        guard let navController = self.navigationController else { return }
        let menuView = Menu.setupMenu(navController, index: 3)
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            Menu.showItemAtIndexPath(self, indexPath: indexPath)
        }
        self.navigationItem.titleView = menuView
    }
    
    @IBAction func done(sender: UIButton) {
        rootViewController()?.showMenu()
    }
    
}
