//
//  SectionsViewController.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView : UITableView!
    var section : Section!
    var basketButton : UIBarButtonItem!
    var forRest : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
        self.navigationItem.title = section.getName()
    }
    
    func setUpView( ) {
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = (20+(UIScreen.main.bounds.width * 0.2))
        self.tableView.register(ProductTableCellViewController.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        basketButton = UIBarButtonItem(image: UIImage(named:"BasketIcon"), style: .plain, target: self, action: #selector(basketButtonAction))
        
        navigationItem.rightBarButtonItems = [basketButton]

    }
    
    func basketButtonAction () {
        BasketHelper.sharedInstance.navToBasket( _navController : self.navigationController!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section.getProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProductTableCellViewController = ProductTableCellViewController(style: .subtitle, reuseIdentifier: "cell", enableAddButton: true, forRest:forRest)
        let rest = self.section.getProducts()[indexPath.row]
        
        cell.setValues(_product: rest)
        //cell.textLabel!.text = rest.getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.section.getProducts()[indexPath.row].getName())
        let productViewController = ProductViewController()
        //self.navigationController?.pushViewController(productViewController, animated: true)
        self.navigationController?.present(productViewController, animated: true, completion: nil)
        //load
        
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
