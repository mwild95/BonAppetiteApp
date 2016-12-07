//
//  BasketViewController.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var subTotalLabel : UILabel!
    var subTotalFigureLabel : UILabel!
    var tableView : UITableView!
    var basketContents : [Product]!
    var emptyLabel : UILabel!
    var payBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.basketContents = BasketHelper.sharedInstance.getBasket()
        self.navigationItem.title = "Basket"
        self.tableView = UITableView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (tabBarController?.tabBar.frame.size.height)!), style: UITableViewStyle.plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = (20+(UIScreen.main.bounds.width * 0.2))
        self.tableView.register(ProductTableCellViewController.self, forCellReuseIdentifier: "cell")
        //self.view.addSubview(constructFooter())
        self.view.addSubview(self.tableView)
        self.view.addSubview(constructFooter())
        //self.view.addSubview(constructFooter())
        // Do any additional setup after loading the view.
        
        self.emptyLabel = UILabel(frame:CGRect(x:0,y:0,width:0,height:0))
        self.emptyLabel.text = "Your basket is empty \u{1F614}"
        self.emptyLabel.sizeToFit()
        self.emptyLabel.center = self.view.center
        self.view.addSubview(self.emptyLabel)
        self.emptyLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.basketContents = BasketHelper.sharedInstance.getBasket()
        if( self.basketContents.count == 0){
            self.tableView.isHidden = true
            self.emptyLabel.isHidden = false
            self.payBtn.isHidden = true
        } else {
            self.subTotalLabel.text = "Sub-Total: £\(BasketHelper.sharedInstance.getSubTotal())"
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.emptyLabel.isHidden = true
            self.payBtn.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func constructFooter ( ) -> UIView {
        let subTotalBar = UIView(frame:CGRect(x:0, y:  UIScreen.main.bounds.height - ((tabBarController?.tabBar.frame.size.height)! * 2), width:UIScreen.main.bounds.width, height : (tabBarController?.tabBar.frame.size.height)!))
        subTotalLabel = UILabel( frame: CGRect(x:10, y:0, width:UIScreen.main.bounds.width * 0.5, height: (tabBarController?.tabBar.frame.size.height)!))
        subTotalLabel.text = "Sub-Total: £\(BasketHelper.sharedInstance.getSubTotal())"
        subTotalBar.addSubview(subTotalLabel)
        
        payBtn = UIButton(frame:CGRect(x:0,y:5,width:100,height:(tabBarController?.tabBar.frame.size.height)! - 10))
        payBtn.setTitle("Checkout", for: .normal)
        payBtn.sizeToFit()
        payBtn.frame.size.height = (tabBarController?.tabBar.frame.size.height)! - 10
        payBtn.frame.origin.x = UIScreen.main.bounds.width - payBtn.frame.size.width - 10
        payBtn.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
        payBtn.defaultStyle()
        
        subTotalBar.addSubview(payBtn)
        
        subTotalBar.backgroundColor = UIColor.lightGray
        return subTotalBar

    }
    
    func payButtonAction ( ) {
        print("Pay for order of sub total \(BasketHelper.sharedInstance.getSubTotal())")
        
        let _ : Void = OrdersHelper.sharedInstance.sendOrder(_owning_user: UserHelper.sharedInstance.getUser().getId(),_products: BasketHelper.sharedInstance.getBasketAsStrings(), _restaurantId: BasketHelper.sharedInstance.getRestaurantId(),onCompletion: {(order: Order?, error: NSError?) -> Void in
            if(error == nil) {
                print("order placed")
                
            }else {
                print("error occured")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.basketContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProductTableCellViewController = ProductTableCellViewController(style: .subtitle, reuseIdentifier: "cell", enableRemoveButton: true, forRest:BasketHelper.sharedInstance.getRestaurantId())
        cell.deleteDelegate = self
        let rest = self.basketContents[indexPath.row]
        cell.setValues(_product: rest)
        //cell.textLabel!.text = rest.getName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.basketContents[indexPath.row].getName())
    }
    
    func reloadTable () {
        self.basketContents = BasketHelper.sharedInstance.getBasket()

        self.tableView.reloadData()
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
