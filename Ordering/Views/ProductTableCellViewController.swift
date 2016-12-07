//
//  ProductTableCellViewController.swift
//  Ordering
//
//  Created by Michael Wild on 18/11/2016.
//  Copyright © 2016 Bon Appetite. All rights reserved.
//

import UIKit

class ProductTableCellViewController: UITableViewCell {

    var product : Product!
    var deleteDelegate : BasketViewController!
    var productTitle : UILabel!
    var productCost : UILabel!
    var productImage : UIImageView!
    var productDescription : UILabel!
    var forRest : String!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.setupView(enableAddButton: false, enableRemoveButton: false)
    }
    
    init(style : UITableViewCellStyle, reuseIdentifier: String?, enableAddButton: Bool?, enableRemoveButton: Bool?, forRest:String) {
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.forRest = forRest
        self.setupView(enableAddButton: enableAddButton!, enableRemoveButton: enableRemoveButton!)
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, enableAddButton: Bool?, forRest:String){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.forRest = forRest
        self.setupView(enableAddButton: enableAddButton!, enableRemoveButton: false)
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, enableRemoveButton: Bool?,  forRest:String){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.forRest = forRest
        self.setupView(enableAddButton: false, enableRemoveButton: enableRemoveButton!)
    }
    
    func setupView(enableAddButton: Bool, enableRemoveButton: Bool) {
        
        let thirdOfRow = (UIScreen.main.bounds.width * 0.2) / 3
        
        
        productTitle = UILabel(frame: CGRect(x:UIScreen.main.bounds.width * 0.2 + 20,y:10, width:200, height:21))
        productCost = UILabel(frame: CGRect(x:UIScreen.main.bounds.width * 0.2 + 20,y:thirdOfRow + 10, width:200, height:21))
        productDescription = UILabel(frame: CGRect(x:UIScreen.main.bounds.width * 0.2 + 20,y:(thirdOfRow * 2) + 30,width:200,height:21))
        // Do any additional setup after loading the view.
        
        let productImage = UIImageView(frame: CGRect(x:10,y:10,width:UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2))
        productImage.backgroundColor = UIColor.gray
        
        let buttonWidthHeight = UIScreen.main.bounds.width * 0.1
        
        let addToBasketBtn = UIButton(frame: CGRect(x:UIScreen.main.bounds.width - 10 - buttonWidthHeight,y: ((UIScreen.main.bounds.width * 0.2) + 20) - 10 - buttonWidthHeight,width:buttonWidthHeight,height:buttonWidthHeight))
        addToBasketBtn.setTitle("+", for: UIControlState())
        addToBasketBtn.defaultStyle()
        addToBasketBtn.layer.cornerRadius = 0.5 * addToBasketBtn.bounds.size.width
        addToBasketBtn.clipsToBounds = true
        addToBasketBtn.addTarget(self, action: #selector(addToBasketButtonAction), for: .touchUpInside)
        
        
        let removeFromBasketBtn = UIButton(frame: CGRect(x:UIScreen.main.bounds.width - 10 - buttonWidthHeight,y: ((UIScreen.main.bounds.width * 0.2) + 20) - 10 - buttonWidthHeight,width:buttonWidthHeight,height:buttonWidthHeight))
        removeFromBasketBtn.setTitle("-", for: UIControlState())
        removeFromBasketBtn.defaultStyle()
        removeFromBasketBtn.backgroundColor = UIColor.red
        removeFromBasketBtn.layer.cornerRadius = 0.5 * removeFromBasketBtn.bounds.size.width
        removeFromBasketBtn.clipsToBounds = true
        removeFromBasketBtn.addTarget(self, action: #selector(removeFromBasketButtonAction), for: .touchUpInside)
       
        if( BasketHelper.sharedInstance.isScannedIn ){
            //user is scanned in 
            //check which restaurant theyre scanned in to
            if( BasketHelper.sharedInstance.getRestaurantId() == forRest ){
                //this is the menu theyre scanned in to.
                removeFromBasketBtn.isHidden = !enableRemoveButton
                addToBasketBtn.isHidden = !enableAddButton
            } else {
                //not scanned in to this restaurant, tell them to scan in
                removeFromBasketBtn.isHidden = true
                addToBasketBtn.isHidden = true
            }
        } else {
            removeFromBasketBtn.isHidden = true
            addToBasketBtn.isHidden = true
        }
        
        
        self.contentView.addSubview(productTitle)
        self.contentView.addSubview(productCost)
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(addToBasketBtn)
        self.contentView.addSubview(removeFromBasketBtn)
        self.contentView.addSubview(productDescription)
    }
    
    
    
    func addToBasketButtonAction ( ) {
        ProductCache.sharedInstance.putProduct(_product: product)
        BasketHelper.sharedInstance.addToBasket(_productToAddId: product.getId())
    }
    
    func removeFromBasketButtonAction ( ) {
        let result = BasketHelper.sharedInstance.removeFromBasket(_productIdToRemove: product.getId())
        if result {
            self.deleteDelegate.reloadTable()
        }
    }
    
    func setValues ( _product : Product ) {
        self.productTitle.text = _product.getName()
        self.productCost.text = "£\(_product.getPrice())"
        self.productDescription.text = _product.getDescription()
        
        self.product = _product
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init (coder: aDecoder)
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
