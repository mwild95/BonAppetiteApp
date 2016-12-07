//
//  SectionsViewController.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class SectionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView : UITableView!
    var menu : Menu!
    var basketButton : UIBarButtonItem!
    var forRest : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView( ) {
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        self.navigationItem.title = menu.getName()
        
        basketButton = UIBarButtonItem(image: UIImage(named:"BasketIcon"), style: .plain, target: self, action: #selector(basketButtonAction))
        
        navigationItem.rightBarButtonItems = [basketButton]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func basketButtonAction () {
        BasketHelper.sharedInstance.navToBasket( _navController : self.navigationController!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.getSections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let rest = self.menu.getSections()[indexPath.row]
        cell.textLabel!.text = rest.getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productListViewController = ProductListViewController()
        productListViewController.section = self.menu.getSections()[indexPath.row]
        productListViewController.forRest = self.forRest
        self.navigationController?.pushViewController(productListViewController, animated: true)
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
